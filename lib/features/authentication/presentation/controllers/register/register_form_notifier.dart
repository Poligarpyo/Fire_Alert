// lib/features/authentication/presentation/controllers/register/register_form_notifier.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'register_form_state.dart';

part 'register_form_notifier.g.dart';

@riverpod
class RegisterFormNotifier extends _$RegisterFormNotifier {
  @override
  RegisterFormState build() => const RegisterFormState();

  void setName(String v) {
    state = state.copyWith(name: v);
    if (state.nameError != null && v.isNotEmpty) {
      setNameError(null);
    }
  }

  void setPhone(String v) {
    state = state.copyWith(phone: v);
    if (state.phoneError != null && v.isNotEmpty) {
      setPhoneError(null);
    }
  }

  void setAddress(String v) {
    state = state.copyWith(address: v);
    if (state.addressError != null && v.isNotEmpty) {
      setAddressError(null);
    }
  }

  void setPassword(String v) {
    state = state.copyWith(password: v);
    if (state.passwordError != null && v.isNotEmpty) {
      setPasswordError(null);
    }
  }

  void setConfirmPassword(String v) {
    state = state.copyWith(confirmPassword: v);
    if (state.confirmPasswordError != null && v.isNotEmpty) {
      setConfirmPasswordError(null);
    }
  }

  void setNameError(String? e) => state = state.copyWith(nameError: e);
  void setPhoneError(String? e) => state = state.copyWith(phoneError: e);
  void setAddressError(String? e) => state = state.copyWith(addressError: e);
  void setPasswordError(String? e) => state = state.copyWith(passwordError: e);
  void setConfirmPasswordError(String? e) =>
      state = state.copyWith(confirmPasswordError: e);

  void toggleObscurePassword() =>
      state = state.copyWith(obscurePassword: !state.obscurePassword);

  void toggleObscureConfirmPassword() => state = state.copyWith(
    obscureConfirmPassword: !state.obscureConfirmPassword,
  );

  void setAcceptedTerms(bool v) => state = state.copyWith(acceptedTerms: v);
  void setSubmitting(bool v) => state = state.copyWith(isSubmitting: v);

  bool validate() {
    bool valid = true;

    if (state.name.trim().isEmpty) {
      setNameError('Full name is required');
      valid = false;
    } else if (state.name.trim().length < 3) {
      setNameError('Name must be at least 3 characters');
      valid = false;
    } else {
      setNameError(null);
    }

    if (state.phone.trim().isEmpty) {
      setPhoneError('Phone number is required');
      valid = false;
    } else if (state.phone.length != 10 || !state.phone.startsWith('9')) {
      setPhoneError('Enter a valid 10-digit PH number starting with 9');
      valid = false;
    } else {
      setPhoneError(null);
    }

    if (state.address.trim().isEmpty) {
      setAddressError('Address is required');
      valid = false;
    } else if (state.address.trim().length < 4) {
      setAddressError('Please enter a complete address');
      valid = false;
    } else {
      setAddressError(null);
    }

    if (state.password.isEmpty) {
      setPasswordError('Password is required');
      valid = false;
    } else if (state.password.length < 8) {
      setPasswordError('Password must be at least 8 characters');
      valid = false;
    } else {
      setPasswordError(null);
    }

    if (state.confirmPassword.isEmpty) {
      setConfirmPasswordError('Please confirm your password');
      valid = false;
    } else if (state.confirmPassword != state.password) {
      setConfirmPasswordError('Passwords do not match');
      valid = false;
    } else {
      setConfirmPasswordError(null);
    }

    return valid;
  }
}
