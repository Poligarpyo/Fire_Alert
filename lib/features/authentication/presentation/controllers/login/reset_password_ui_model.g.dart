// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_ui_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResetPasswordUiModel _$ResetPasswordUiModelFromJson(
  Map<String, dynamic> json,
) => _ResetPasswordUiModel(
  isLoading: json['isLoading'] as bool? ?? false,
  successMessage: json['successMessage'] as String?,
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$ResetPasswordUiModelToJson(
  _ResetPasswordUiModel instance,
) => <String, dynamic>{
  'isLoading': instance.isLoading,
  'successMessage': instance.successMessage,
  'errorMessage': instance.errorMessage,
};
