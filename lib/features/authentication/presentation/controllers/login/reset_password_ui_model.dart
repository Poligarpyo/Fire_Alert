import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_ui_model.freezed.dart';
part 'reset_password_ui_model.g.dart';

@freezed
abstract class ResetPasswordUiModel with _$ResetPasswordUiModel {
  const factory ResetPasswordUiModel({
    @Default(false) bool isLoading,
    String? successMessage,
    String? errorMessage,
  }) = _ResetPasswordUiModel;

  factory ResetPasswordUiModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordUiModelFromJson(json);
}
