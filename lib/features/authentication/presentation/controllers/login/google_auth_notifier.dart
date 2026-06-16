import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/services/google_auth_service.dart';
import '../auth/auth_controller.dart';

part 'google_auth_notifier.freezed.dart';
part 'google_auth_notifier.g.dart';

@freezed
sealed class GoogleAuthState with _$GoogleAuthState {
  const factory GoogleAuthState.initial() = _Initial;
  const factory GoogleAuthState.loading() = _Loading;
  const factory GoogleAuthState.success(String email) = _Success;
  const factory GoogleAuthState.error(String message) = _Error;
}

@riverpod
class GoogleAuthNotifier extends _$GoogleAuthNotifier {
  @override
  GoogleAuthState build() => const GoogleAuthState.initial();

  Future<void> signInWithGoogle() async {
    state = const GoogleAuthState.loading();
    try {
      final service = ref.read(googleAuthServiceProvider);
      await service.initialize();
      final userCredential = await service.signInWithGoogle();

      if (userCredential == null) {
        state = const GoogleAuthState.initial();
        return;
      }
      await handleGoogleLogin();
      state = GoogleAuthState.success(userCredential.user?.email ?? '');
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      state = GoogleAuthState.error(errorMessage);
    }
  }

  Future<void> signOut() async {
    try {
      final GoogleAuthService service = ref.read(googleAuthServiceProvider);
      await service.signOut();
      state = const GoogleAuthState.initial();
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      state = GoogleAuthState.error(errorMessage);
    }
  }

  Future<void> handleGoogleLogin() async {
    ref.listen<GoogleAuthState>(googleAuthProvider, (_, next) {
      next.when(
        initial: () {},
        loading: () {},
        success: (email) {
          ref
              .read(authControllerProvider.notifier)
              .loginSuccess(
                token: '123456789', // replace with real token if available
                phone: '9225516147', // replace with real phone if available
              );
        },
        error: (message) {
          // print("Google Login Error: $message");
          // ref
          //     .read(authControllerProvider.notifier)
          //     .loginFailure(message);
        },
      );
    });
  }

  String _mapError(String rawError) {
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('canceled') || rawError.contains('user-cancelled')) {
      return 'Google sign-in was cancelled.';
    }
    if (rawError.contains('sign-in-failed') ||
        rawError.contains('sign_in_failed')) {
      return 'Google sign-in failed. Please try again.';
    }
    if (rawError.contains('account-exists-with-different-credential')) {
      return 'This email is already registered with a different sign-in method.';
    }
    if (rawError.contains('invalid-credential')) {
      return 'Invalid Google credentials. Please try again.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }
}
