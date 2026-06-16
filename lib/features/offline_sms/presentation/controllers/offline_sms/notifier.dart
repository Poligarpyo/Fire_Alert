import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../../core/provider/device_id_provider.dart';
import '../../../../../core/provider/ip_address_provider.dart';
import '../../../../../core/services/device_service.dart';
import '../../../../../core/services/ip_address_service.dart';
import '../../../../../core/value_objects/phone_number.dart';
import '../../../../../shared/constants/strings.dart';
import '../../../domain/entities/offline_sms.dart';
import '../../../domain/repositories/offline_sms_repository.dart';
import '../../../domain/usecases/set_offline_sms_usecase.dart';
import '../../../../../core/geolocator/get_current_location.dart'
    as locationService;
import '../../providers/offline_sms_providers.dart';
import 'state.dart';

// ─── Provider ────────────────────────────────────────────────────────────────

final offlineSmsNotifierProvider =
    StateNotifierProvider<OfflineSmsNotifier, OfflineSmsState>((ref) {
      return OfflineSmsNotifier(
        ref.read(sendOfflineSmsUseCaseProvider),
        ref.read(offlineSmsRepositoryProvider),
        ref.read(ipAddressServiceProvider),
        ref.read(deviceIdServiceProvider),
      );
    });

// ─── Notifier ────────────────────────────────────────────────────────────────

class OfflineSmsNotifier extends StateNotifier<OfflineSmsState> {
  OfflineSmsNotifier(
    this.useCase,
    this.repository,
    this.ipAddressService,
    this.deviceIdService,
  ) : super(OfflineSmsState.initial());

  final SendOfflineSmsUseCase useCase;
  final OfflineSmsRepository repository;
  final IpAddressService ipAddressService;
  final DeviceIdService deviceIdService;

  // ─── Actions ─────────────────────────────────────────────────────────────

  Future<void> handleEmergency() async {
    final message = state.message.trim();
    final phone = state.phone;

    if (message.isEmpty) {
      state = state.copyWith(error: 'Message cannot be empty');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final phoneNumber = PhoneNumber.parse(phone);
      final pending = await repository.getPendingCount();

      if (pending > 0) {
        state = state.copyWith(
          isLoading: false,
          error: 'You have already sent an emergency message. Please wait.',
          shouldCloseDialog: true,
        );
        return;
      }

      final position = await locationService.getCurrentLocation();
      final generatedDeviceId = await deviceIdService.getDeviceId();

      print("generatedDeviceId $generatedDeviceId");

      final smsMessage =
          '$message\nLocation: ${position.latitude}, ${position.longitude}';

      final offlineSms = OfflineSms(
        id: Strings.uuid.v4(),
        message: smsMessage,
        latitude: position.latitude,
        longitude: position.longitude,
        createdAt: DateTime.now(),
        phoneNumber: phoneNumber.value,
        localIpAddress: '',
        deviceId: generatedDeviceId,
      );

      await useCase.execute(offlineSms);

      state = state.copyWith(isLoading: false, success: true);
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      state = state.copyWith(isLoading: false, error: errorMessage);
    }
  }

  Future<void> syncReports() async {
    try {
      final pending = await repository.getPendingCount();

      if (pending == 0) {
        state = state.copyWith(
          hasPendingSync: false,
          error: 'No pending reports to sync.',
        );
        return;
      }

      await repository.syncPendingReports();

      state = state.copyWith(syncedCount: pending, hasPendingSync: true);
      await Future.delayed(const Duration(seconds: 2));
      state = state.copyWith(syncedCount: 0, hasPendingSync: false);
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      state = state.copyWith(error: errorMessage);
    }
  }

  // ─── Field Updates ────────────────────────────────────────────────────────

  void updateMessage(String message) =>
      state = state.copyWith(message: message);

  void updatePhone(String phone) => state = state.copyWith(phone: phone);

  void updateMaxCharacters(int max) =>
      state = state.copyWith(maxCharacters: max);

  // ─── UI State Helpers ─────────────────────────────────────────────────────

  void resetStatus() => state = state.copyWith(success: false, error: null);

  void resetError() => state = state.copyWith(error: null);

  void cancel() => state = state.copyWith(shouldCloseDialog: true);

  void resetCloseDialog() => state = state.copyWith(shouldCloseDialog: false);

  String _mapError(String rawError) {
    if (rawError.contains('location') || rawError.contains('Location')) {
      return 'Unable to get your current location. Please enable location services.';
    }
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
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }
}
