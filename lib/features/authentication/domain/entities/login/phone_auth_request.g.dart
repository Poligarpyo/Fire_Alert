// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhoneAuthRequest _$PhoneAuthRequestFromJson(Map<String, dynamic> json) =>
    _PhoneAuthRequest(
      phoneNumber: json['phoneNumber'] as String,
      verificationId: json['verificationId'] as String?,
      smsCode: json['smsCode'] as String?,
    );

Map<String, dynamic> _$PhoneAuthRequestToJson(_PhoneAuthRequest instance) =>
    <String, dynamic>{
      'phoneNumber': instance.phoneNumber,
      'verificationId': instance.verificationId,
      'smsCode': instance.smsCode,
    };
