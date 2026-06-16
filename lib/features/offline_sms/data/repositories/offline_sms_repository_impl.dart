import 'dart:io';
import 'dart:math';

import 'package:another_telephony/telephony.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/database/app_database.dart';
import '../../../../core/services/connectivity_service.dart';
import '../../domain/entities/offline_sms.dart';
import '../../domain/repositories/offline_sms_repository.dart';
import '../models/offline_sms_model.dart';
import '../sources/offline_sms_remote_source.dart';

class OfflineSmsRepositoryImpl implements OfflineSmsRepository {
  OfflineSmsRepositoryImpl({
    required this.database,
    required this.remoteDataSource,
    required this.connectivity,
    required this.telephony,
  });

  final AppDatabase database;
  final OfflineSmsRemoteSource remoteDataSource;
  final ConnectivityService connectivity;
  final Telephony telephony;
  static const String _emergencyNumber = '+639051901129'; // ✅ with country code

  // ─── Save ────────────────────────────────────────────────────────────────────

  @override
  Future<void> saveOffline(OfflineSms sms) async {
    try {
      await database.insertReport(sms.toCompanion(sent: false));
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      throw Exception(errorMessage);
    }
  }

  // ─── Sync ────────────────────────────────────────────────────────────────────

  @override
  Future<void> syncPendingReports() async {
    if (!await connectivity.isConnected) return;

    final List<EmergencyReport> pending;
    try {
      pending = await database.getPendingReports();
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      throw Exception(errorMessage);
    }

    if (pending.isEmpty) return;

    for (final item in pending) {
      await _syncItem(item);
    }
  }

  /// Handles one pending record:
  /// 1. Check Firestore for a prior record from the same device.
  /// 2. If within 3km AND within 1 hour → duplicate, delete locally and throw.
  /// 3. Otherwise → push to Firestore and clean up local record.
  Future<void> _syncItem(EmergencyReport item) async {
    // ── Step 1: Duplicate check ──────────────────────────────────────────────
    OfflineSmsModel? latest;
    try {
      latest = await remoteDataSource.checkNearDeviceId(item.deviceId ?? '');
    } catch (e) {
      // Firestore check failed — keep local record for next sync attempt.
      String errorMessage = _mapError(e.toString());
      throw Exception(errorMessage);
    }

    if (latest != null && latest.createdAt != null) {
      final distance = _distanceKm(
        item.latitude,
        item.longitude,
        latest.latitude,
        latest.longitude,
      );
      final withinOneHour =
          DateTime.now().difference(latest.createdAt!).inMinutes.abs() < 60;

      if (distance <= 3.0 && withinOneHour) {
        // Duplicate — drop local record, surface error to the notifier.
        try {
          await database.deleteReport(item.id);
        } catch (_) {
          // Deletion failed — not critical, will be re-evaluated next sync.
        }
        throw Exception(
          'Duplicate emergency report detected within 1 hour nearby. '
          'Your report was not synced.',
        );
      }
    }

    // ── Step 2: Push to Firestore ────────────────────────────────────────────
    try {
      await remoteDataSource.sendReport(item.toEntity());
    } catch (e) {
      // Push failed — keep local record for retry on next sync.
      String errorMessage = _mapError(e.toString());
      throw Exception(errorMessage);
    }

    // ── Step 3: Clean up local record ────────────────────────────────────────
    try {
      await database.updateReportSyncStatus(item.id);
      await database.deleteReport(item.id);
    } catch (e) {
      // Push succeeded but cleanup failed.
      // .set() is idempotent so re-sending on retry is safe.
      String errorMessage = _mapError(e.toString());
      throw Exception(errorMessage);
    }
  }

  // ─── Send SMS ────────────────────────────────────────────────────────────────

  @override
  Future<void> sendEmergencySMS(String message) async {
    if (Platform.isAndroid) {
      await _sendAndroid(message);
    } else if (Platform.isIOS) {
      await _launchSmsIntent(_emergencyNumber, message);
    } else {
      throw Exception('SMS not supported on this platform');
    }
  }

  Future<void> _sendAndroid(String message) async {
    final status = await Permission.sms.status;

    // ✅ Check permanentlyDenied BEFORE requesting — avoids silent no-op
    if (status.isPermanentlyDenied) {
      // Degrade gracefully — open pre-filled SMS app, no permission needed
      await _launchSmsIntent(_emergencyNumber, message);
      return;
    }

    // Request if not yet determined
    final result = status.isGranted ? status : await Permission.sms.request();

    if (result.isGranted) {
      // ✅ Direct background send — best UX for emergency
      try {
        await telephony.sendSms(
          to: _emergencyNumber,
          message: message,
          isMultipart: true, // handles long messages gracefully
        );
      } catch (e) {
        // Telephony failed — fall back to intent rather than hard-failing
        await _launchSmsIntent(_emergencyNumber, message);
      }
    } else {
      // Denied but not permanently — still degrade gracefully
      await _launchSmsIntent(_emergencyNumber, message);
    }
  }

  Future<void> _launchSmsIntent(String number, String message) async {
    final uri = Uri(
      scheme: 'sms',
      path: number,
      queryParameters: {'body': message},
    );
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not open SMS app. No SMS client available.');
    }
  }

  // ─── Queries ─────────────────────────────────────────────────────────────────

  @override
  Future<int> getPendingCount() async {
    try {
      final pending = await database.getPendingReports();
      return pending.length;
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      throw Exception(errorMessage);
    }
  }

  @override
  Future<OfflineSms?> getLatestOfflineSms() async {
    try {
      final model = await remoteDataSource.getLatestOfflineSms();
      if (model == null) return null;
      return OfflineSms(
        id: model.id,
        message: model.message,
        phoneNumber: model.phoneNumber,
        latitude: model.latitude,
        longitude: model.longitude,
        createdAt: model.createdAt,
        localIpAddress: model.localIpAddress,
        deviceId: model.deviceId,
      );
    } catch (_) {
      // Firestore unreachable — caller falls back to device GPS.
      return null;
    }
  }

  // ─── Helpers ─────────────────────────────────────────────────────────────────

  double _distanceKm(double lat1, double lng1, double lat2, double lng2) {
    const r = 6371.0;
    final dLat = _toRad(lat2 - lat1);
    final dLng = _toRad(lng2 - lng1);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRad(lat1)) * cos(_toRad(lat2)) * sin(dLng / 2) * sin(dLng / 2);
    return r * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  double _toRad(double deg) => deg * (pi / 180);

  String _mapError(String rawError) {
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('permission')) {
      return 'Permission denied. Please grant the necessary permissions.';
    }
    if (rawError.contains('database') || rawError.contains('storage')) {
      return 'Failed to save report. Please try again.';
    }
    if (rawError.contains('sms') || rawError.contains('telephony')) {
      return 'Failed to send SMS. Please try again.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }
}

// ─── Extension ───────────────────────────────────────────────────────────────

extension on EmergencyReport {
  OfflineSmsModel toEntity() {
    return OfflineSmsModel(
      id: id,
      message: message,
      phoneNumber: phoneNumber ?? '',
      latitude: latitude,
      longitude: longitude,
      syncStatus: syncStatus,
      createdAt: createdAt,
      localIpAddress: localIpAddress,
      deviceId: deviceId,
    );
  }
}
