import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth/auth_controller.dart';
import '../../../domain/entities/login/login_request.dart';
import '../../../domain/usecases/login/login_usecase.dart';
import 'auth_ui_model.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  @override
  AuthUiModel build() => const AuthUiModel();

  Future<String?> login({
    required String phone,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final credentials = LoginCredentials(phone: phone, password: password);

    final result = await ref.read(loginUseCaseProvider).execute(credentials);

    if (!ref.mounted) return null;

    String? token;

    result.when(
      success: (response) {
        token = response.token;
      },
      failure: (error) {
        String errorMessage = _mapError(error.message.toString());
        state = state.copyWith(errorMessage: errorMessage);
      },
    );

    if (ref.mounted) {
      state = state.copyWith(isLoading: false);
    }

    return token;
  }

  String _mapError(String rawError) {
    if (rawError.contains('user-not-found') ||
        rawError.contains('invalid-credential')) {
      return 'Invalid phone number or password. Please check and try again.';
    }
    if (rawError.contains('wrong-password') ||
        rawError.contains('invalid-password')) {
      return 'Incorrect password. Please try again.';
    }
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection and try again.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('too-many-requests') || rawError.contains('429')) {
      return 'Too many login attempts. Please wait a few minutes and try again.';
    }
    if (rawError.contains('user-disabled')) {
      return 'This account has been disabled. Please contact support.';
    }
    if (rawError.contains('invalid-email') ||
        rawError.contains('invalid-phone')) {
      return 'Invalid phone number format. Please check and try again.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }
}
