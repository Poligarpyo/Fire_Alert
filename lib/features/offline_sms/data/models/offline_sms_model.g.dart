// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_sms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_OfflineSmsModel _$OfflineSmsModelFromJson(Map<String, dynamic> json) =>
    _OfflineSmsModel(
      id: json['id'] as String,
      message: json['message'] as String,
      phoneNumber: json['phone_number'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      sentViaSms: json['sentViaSms'] as bool? ?? false,
      syncStatus: (json['syncStatus'] as num?)?.toInt() ?? 0,
      createdAt: const _TimestampConverter().fromJson(json['createdAt']),
      localIpAddress: json['localIpAddress'] as String?,
      deviceId: json['deviceId'] as String?,
    );

Map<String, dynamic> _$OfflineSmsModelToJson(_OfflineSmsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'phone_number': instance.phoneNumber,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'sentViaSms': instance.sentViaSms,
      'syncStatus': instance.syncStatus,
      'createdAt': const _TimestampConverter().toJson(instance.createdAt),
      'localIpAddress': instance.localIpAddress,
      'deviceId': instance.deviceId,
    };
