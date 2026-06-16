import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../domain/entities/login/reset_password_request.dart';
import '../../../domain/usecases/reset_password_usecase.dart';
import 'reset_password_ui_model.dart';

part 'reset_password_controller.g.dart';

@riverpod
class ResetPasswordController extends _$ResetPasswordController {
  @override
  ResetPasswordUiModel build() => const ResetPasswordUiModel();

  Future<bool> resetPassword({
    required String phone,
    required String password,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
      successMessage: null,
    );

    final result = await ref.read(resetPasswordUseCaseProvider).execute(
          ResetPasswordRequest(phone: phone, password: password),
        );

    var success = false;

    result.when(
      success: (_) {
        state = state.copyWith(
          successMessage: 'Password updated successfully. Please login again.',
        );
        success = true;
      },
      failure: (error) {
        var cleanMessage = error.message;
        if (cleanMessage.startsWith('Exception: ')) {
          cleanMessage = cleanMessage.substring(11);
        }
        state = state.copyWith(errorMessage: cleanMessage);
      },
    );

    if (ref.mounted) {
      state = state.copyWith(isLoading: false);
    }

    return success;
  }
}
