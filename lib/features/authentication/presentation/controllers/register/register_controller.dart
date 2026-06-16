import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/register/register_request.dart';
import '../../../domain/usecases/register/register_user.dart';
import 'register_state.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  @override
  RegisterState build() => const RegisterState.initial();

  Future<void> register({
    required String name,
    required String phone,
    required String address,
    required String password,
  }) async {
    state = const RegisterState.loading();

    final result = await ref
        .read(registerUserUseCaseProvider)
        .call(
          RegisterRequest(
            name: name,
            phone: phone,
            address: address,
            password: password,
          ),
        );

    if (!ref.mounted) return;

    result.when(
      success: (data) => state = RegisterState.success(data.message),
      failure: (error) {
        String errorMessage = _mapError(error.message);
        state = RegisterState.error(errorMessage);
      },
    );
  }

  String _mapError(String rawError) {
    if (rawError.contains('email-already-in-use') ||
        rawError.contains('phone-already-in-use')) {
      return 'This phone number is already registered. Please login instead.';
    }
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection and try again.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('permission-denied') || rawError.contains('403')) {
      return 'Permission denied. Please contact support.';
    }
    if (rawError.contains('invalid-phone') ||
        rawError.contains('invalid-phone-number')) {
      return 'Invalid phone number format. Please check and try again.';
    }
    if (rawError.contains('too-many-requests') || rawError.contains('429')) {
      return 'Too many attempts. Please wait a few minutes and try again.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }
}
