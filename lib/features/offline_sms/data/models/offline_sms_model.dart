import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/offline_sms.dart';

part 'offline_sms_model.freezed.dart';
part 'offline_sms_model.g.dart';

/// Handles Firestore Timestamp ↔ DateTime conversion.
/// Also handles null and plain String dates from older records.
class _TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const _TimestampConverter();

  @override
  DateTime? fromJson(Object? value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  @override
  Object? toJson(DateTime? date) =>
      date != null ? Timestamp.fromDate(date) : null;
}

@freezed
abstract class OfflineSmsModel with _$OfflineSmsModel {
  const factory OfflineSmsModel({
    required String id,
    required String message,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    required double latitude,
    required double longitude,
    @Default(false) bool sentViaSms,
    @Default(0) int syncStatus,
    @_TimestampConverter() DateTime? createdAt, // ← fixes Timestamp crash
    String? localIpAddress,
    String? deviceId,
  }) = _OfflineSmsModel;

  const OfflineSmsModel._();

  factory OfflineSmsModel.fromJson(Map<String, dynamic> json) =>
      _$OfflineSmsModelFromJson(json);
}

extension OfflineSmsModelX on OfflineSmsModel {
  OfflineSms toEntity() => OfflineSms(
    id: id,
    message: message,
    phoneNumber: phoneNumber,
    latitude: latitude,
    longitude: longitude,
    sentViaSms: sentViaSms,
    syncStatus: syncStatus,
    createdAt: createdAt,
    localIpAddress: localIpAddress,
    deviceId: deviceId,
  );

  static OfflineSmsModel fromEntity(OfflineSms sms) => OfflineSmsModel(
    id: sms.id,
    message: sms.message,
    phoneNumber: sms.phoneNumber,
    latitude: sms.latitude,
    longitude: sms.longitude,
    sentViaSms: sms.sentViaSms,
    syncStatus: sms.syncStatus,
    createdAt: sms.createdAt,
    localIpAddress: sms.localIpAddress,
    deviceId: sms.deviceId,
  );
}
