import 'package:freezed_annotation/freezed_annotation.dart';
part 'phone_auth_request.freezed.dart';
part 'phone_auth_request.g.dart';

@freezed
abstract class PhoneAuthRequest with _$PhoneAuthRequest {
  const factory PhoneAuthRequest({
    required String phoneNumber,
    String? verificationId,
    String? smsCode,
  }) = _PhoneAuthRequest;

  factory PhoneAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$PhoneAuthRequestFromJson(json);
}