import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

import '../../../../core/storage/auth_local_datasource.dart';
import '../models/report_incident_model.dart';

/// Persists incident reports to Realtime Database [`incident_reports`] and optional
/// photos under Storage path `incident_reports/{id}/photo.{ext}`.
class ReportIncidentFirebaseSource {
  const ReportIncidentFirebaseSource({
    required this.database,
    required this.storage,
    required this.auth,
    required this.authLocalDataSource,
  });

  static const _collection = 'incident_reports';

  final FirebaseDatabase database;
  final FirebaseStorage storage;
  final FirebaseAuth auth;
  final AuthLocalDataSource authLocalDataSource;

  Future<void> sendReport(ReportIncidentModel report) async {
    try {
      final docId = const Uuid().v4();
      String? photoUrl;

      // ✅ Use pre-compressed bytes — no re-compression here
      if (report.compressedImageBytes != null) {
        final ref = storage.ref('$_collection/$docId/photo.jpg');
        await ref.putData(
          report.compressedImageBytes!,
          SettableMetadata(contentType: 'image/jpeg'),
        );
        photoUrl = await ref.getDownloadURL();
      }

      final login = authLocalDataSource.getPhone();
      final phone = (login != null && login.isNotEmpty)
          ? login
          : (auth.currentUser?.phoneNumber ?? '');
      final uid = auth.currentUser?.uid;

      await database.ref('$_collection/$docId').set({
        'id': docId,
        'phone': phone,
        if (uid != null && uid.isNotEmpty) 'reporterUid': uid,
        'incident_type': report.incidentType,
        'details': report.additionalDetails,
        if (report.rescuerSelection != null && report.rescuerSelection!.isNotEmpty)
          'rescuer_selection': report.rescuerSelection,
        'latitude': report.latitude,
        'longitude': report.longitude,
        if (photoUrl != null) 'photoUrl': photoUrl,
        'status': 'pending',
        'createdAt': DateTime.now().toIso8601String(),
      });
    } on FirebaseException catch (e) {
      String errorMessage = _mapFirebaseError(e);
      throw Exception(errorMessage);
    }
  }

  static String _contentTypeForExtension(String ext) {
    switch (ext.toLowerCase()) {
      case '.png':
        return 'image/png';
      case '.webp':
        return 'image/webp';
      case '.heic':
        return 'image/heic';
      default:
        return 'image/jpeg';
    }
  }

  Future<int> countNearbyRecentReports({
    required double latitude,
    required double longitude,
    double radiusMeters = 300,
    int withinMinutes = 60,
  }) async {
    final snapshot = await database.ref(_collection).get();
    if (!snapshot.exists || snapshot.value == null) return 0;

    final map = Map<String, dynamic>.from(snapshot.value as Map);
    final now = DateTime.now();
    int count = 0;

    for (final entry in map.values) {
      final doc = Map<String, dynamic>.from(entry as Map);

      // Parse createdAt
      final createdAtStr = doc['createdAt'] as String?;
      if (createdAtStr == null) continue;
      final createdAt = DateTime.tryParse(createdAtStr);
      if (createdAt == null) continue;

      // Check within 1 hour
      final diff = now.difference(createdAt).inMinutes;
      if (diff > withinMinutes) continue;

      // Check within radius
      final lat = (doc['latitude'] as num?)?.toDouble();
      final lng = (doc['longitude'] as num?)?.toDouble();
      if (lat == null || lng == null) continue;

      final distance = _distanceMeters(latitude, longitude, lat, lng);
      if (distance <= radiusMeters) count++;
    }

    return count;
  }

  double _distanceMeters(double lat1, double lng1, double lat2, double lng2) {
    const R = 6371000.0;
    final dLat = _rad(lat2 - lat1);
    final dLng = _rad(lng2 - lng1);
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_rad(lat1)) * cos(_rad(lat2)) * sin(dLng / 2) * sin(dLng / 2);
    return R * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  double _rad(double deg) => deg * pi / 180;

  String _mapFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'unauthorized':
      case 'permission-denied':
        return 'Permission denied. Please contact support.';
      case 'network-request-failed':
      case 'unavailable':
        return 'Network error. Please check your internet connection.';
      case 'timeout':
        return 'Request timed out. Please try again.';
      case 'quota-exceeded':
        return 'Storage quota exceeded. Please try again later.';
      case 'canceled':
        return 'Operation was cancelled.';
      default:
        return e.message ?? 'Failed to save incident report.';
    }
  }
}
