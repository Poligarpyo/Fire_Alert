import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../domain/usecases/register/verify_phone_usecase.dart';

part 'phone_auth_controller.freezed.dart';
part 'phone_auth_controller.g.dart';

// --- State (mirrors your auth_ui_model.dart pattern) ---
@freezed
class PhoneAuthState with _$PhoneAuthState {
  const factory PhoneAuthState.initial() = _Initial;
  const factory PhoneAuthState.sendingOtp() = _SendingOtp;
  const factory PhoneAuthState.otpSent(String verificationId) = _OtpSent;
  const factory PhoneAuthState.verifying() = _Verifying;
  const factory PhoneAuthState.success() = _Success;
  const factory PhoneAuthState.error(String message) = _Error;
}

// --- Notifier ---
@riverpod
class PhoneAuthController extends _$PhoneAuthController {
  @override
  PhoneAuthState build() => const PhoneAuthState.initial();

  Future<void> sendOtp(String phoneNumber) async {
    state = const PhoneAuthState.sendingOtp();

    final usecase = ref.read(verifyPhoneUsecaseProvider);

    await usecase.sendOtp(
      phoneNumber: phoneNumber,
      onCodeSent: (verificationId, _) {
        state = PhoneAuthState.otpSent(verificationId);
      },
      onFailed: (error) {
        state = PhoneAuthState.error(error);
      },
      onAutoVerified: (credential) async {
        state = const PhoneAuthState.verifying();
        try {
          final result = await FirebaseAuth.instance.signInWithCredential(
            credential,
          );
          if (result.user != null) {
            state = const PhoneAuthState.success();
          } else {
            state = const PhoneAuthState.error('Auto-verification failed.');
          }
        } on FirebaseAuthException catch (e) {
          state = PhoneAuthState.error(
            e.message ?? 'Auto-verification failed.',
          );
        }
      },
    );
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    state = const PhoneAuthState.verifying();

    try {
      final usecase = ref.read(verifyPhoneUsecaseProvider);
      final credential = await usecase.verifyOtp(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      if (credential.user != null) {
        state = const PhoneAuthState.success();
      } else {
        state = const PhoneAuthState.error('Verification failed. Try again.');
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = _mapOtpError(e);
      state = PhoneAuthState.error(errorMessage);
    } catch (e) {
      state = const PhoneAuthState.error(
        'Something went wrong. Please try again.',
      );
    }
  }

  String _mapOtpError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-verification-code':
      case 'invalid-verification-id':
        return 'Invalid verification code. Please check and try again.';
      case 'code-expired':
        return 'Verification code has expired. Please request a new one.';
      case 'quota-exceeded':
        return 'Too many attempts. Please wait a few minutes and try again.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'app-not-authorized':
      case 'app-not-verified':
        return 'App verification failed. Please ensure you have the latest version of the app.';
      default:
        final message = e.message ?? '';
        if (message.contains('app identifier') ||
            message.contains('Play Integrity') ||
            message.contains('reCAPTCHA')) {
          return 'Unable to verify phone number. This may be due to security checks. Please try again or contact support if the issue persists.';
        }
        if (message.isNotEmpty) {
          return 'Verification failed: ${message}';
        }
        return 'Invalid OTP. Please try again.';
    }
  }
}
