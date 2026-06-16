// lib/features/authentication/presentation/controllers/register/register_form_state.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_form_state.freezed.dart';

@freezed
abstract class RegisterFormState with _$RegisterFormState {
  const factory RegisterFormState({
    @Default('') String name,
    @Default('') String phone,
    @Default('') String address,
    @Default('') String password,
    @Default('') String confirmPassword,
    String? nameError,
    String? phoneError,
    String? addressError,
    String? passwordError,
    String? confirmPasswordError,
    @Default(true) bool obscurePassword,
    @Default(true) bool obscureConfirmPassword,
    @Default(false) bool acceptedTerms,
    @Default(false) bool isSubmitting,
  }) = _RegisterFormState;
}