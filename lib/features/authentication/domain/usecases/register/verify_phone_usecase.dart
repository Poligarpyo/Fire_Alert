import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'verify_phone_usecase.g.dart';

@riverpod
VerifyPhoneUsecase verifyPhoneUsecase(Ref ref) {
  return VerifyPhoneUsecase(FirebaseAuth.instance);
}

class VerifyPhoneUsecase {
  final FirebaseAuth _auth;
  VerifyPhoneUsecase(this._auth);

  // Step 1 — Send OTP
  Future<void> sendOtp({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(String error) onFailed,
    required void Function(PhoneAuthCredential credential) onAutoVerified,
  }) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber, // e.g. "+639171234567"
      timeout: const Duration(seconds: 60),
      verificationCompleted: onAutoVerified, // Android auto-fills OTP
      verificationFailed: (e) {
        String errorMessage = _mapVerificationError(e);
        onFailed(errorMessage);
      },
      codeSent: (verificationId, resendToken) =>
          onCodeSent(verificationId, resendToken),
      codeAutoRetrievalTimeout: (_) {},
    );
  }

  String _mapVerificationError(FirebaseAuthException e) {
    final message = e.message ?? '';

    // Handle Play Integrity/reCAPTCHA errors
    if (message.contains('app identifier') ||
        message.contains('Play Integrity') ||
        message.contains('reCAPTCHA')) {
      return 'Unable to verify phone number. This may be due to security checks. Please try again or contact support if the issue persists.';
    }

    // Handle specific error codes
    switch (e.code) {
      case 'invalid-phone-number':
        return 'Invalid phone number format. Please check and try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait a few minutes and try again.';
      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try again later.';
      case 'app-not-authorized':
      case 'app-not-verified':
        return 'App verification failed. Please ensure you have the latest version of the app.';
      default:
        return message.isNotEmpty
            ? message
            : 'Verification failed. Please try again.';
    }
  }

  // Step 2 — Verify OTP
  Future<UserCredential> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return _auth.signInWithCredential(credential);
  }
}
