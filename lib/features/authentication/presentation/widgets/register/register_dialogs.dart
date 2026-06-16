import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../shared/theme/app_theme.dart';
import '../../controllers/register/phone_auth_controller.dart';

// ── OTP Dialog ────────────────────────────────────────────────────────────────

Future<void> showOtpDialog({
  required BuildContext context,
  required WidgetRef ref,
  required String verificationId,
  required String phoneNumber,
  required VoidCallback onResend,
  required VoidCallback onCancel,
}) {
  final otpControllers = List.generate(6, (_) => TextEditingController());
  final focusNodes = List.generate(6, (_) => FocusNode());
  String? otpError;
  String getOtpCode() => otpControllers.map((c) => c.text).join();

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => StatefulBuilder(
      builder: (context, setDialogState) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          decoration: BoxDecoration(
            color: AppTheme.backgroundWhite,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.12),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 28),
                decoration: BoxDecoration(
                  color: AppTheme.primaryRed,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppTheme.radius24),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.backgroundWhite.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.lock_outline_rounded,
                        color: AppTheme.textWhite,
                        size: context.responsiveIconSize(
                          small: 28,
                          medium: 32,
                          large: 36,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: context.responsiveSpacing(
                        small: AppTheme.spacing8,
                        medium: AppTheme.spacing12,
                        large: AppTheme.spacing16,
                      ),
                    ),
                    Text(
                      'Verify Your Number',
                      style: context.responsiveTextStyle(
                        baseStyle: AppTheme.h5.copyWith(
                          color: AppTheme.textWhite,
                          letterSpacing: 0.3,
                        ),
                        fontSizeSmall: AppTheme.fontSize16,
                        fontSizeMedium: AppTheme.fontSize20,
                        fontSizeLarge: AppTheme.fontSize24,
                      ),
                    ),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: context.responsiveTextStyle(
                          baseStyle: AppTheme.bodyMedium.copyWith(
                            color: AppTheme.textSecondary,
                            height: 1.5,
                          ),
                          fontSizeSmall: AppTheme.fontSize12,
                          fontSizeMedium: AppTheme.fontSize14,
                          fontSizeLarge: AppTheme.fontSize16,
                        ),
                        children: [
                          TextSpan(text: 'We sent a 6-digit code to\n'),
                          TextSpan(
                            text: '+63 $phoneNumber',
                            style: context.responsiveTextStyle(
                              baseStyle: AppTheme.bodyMedium.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppTheme.textPrimary,
                              ),
                              fontSizeSmall: AppTheme.fontSize12,
                              fontSizeMedium: AppTheme.fontSize14,
                              fontSizeLarge: AppTheme.fontSize16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // OTP boxes
                    Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: List.generate(6, (i) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppTheme.spacing4,
                              ),
                              child: SizedBox(
                                height: context.responsiveValue(
                                  small: 48,
                                  medium: 56,
                                  large: 64,
                                ),
                                child: TextField(
                                  controller: otpControllers[i],
                                  focusNode: focusNodes[i],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  style: context.responsiveTextStyle(
                                    baseStyle: AppTheme.inputLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary,
                                    ),
                                    fontSizeSmall: AppTheme.fontSize10,
                                    fontSizeMedium: AppTheme.fontSize12,
                                    fontSizeLarge: AppTheme.fontSize14,
                                  ),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    filled: true,
                                    fillColor: otpError != null
                                        ? AppTheme.errorRed.withOpacity(0.1)
                                        : AppTheme.surfaceGrey,
                                    contentPadding: EdgeInsets.zero,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radius8,
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppTheme.radius8,
                                      ),
                                      borderSide: const BorderSide(
                                        color: AppTheme.primaryRed,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    if (otpError != null) {
                                      setDialogState(() => otpError = null);
                                    }
                                    if (value.isNotEmpty && i < 5) {
                                      focusNodes[i + 1].requestFocus();
                                    } else if (value.isEmpty && i > 0) {
                                      focusNodes[i - 1].requestFocus();
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    // Error
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) => SizeTransition(
                        sizeFactor: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                      child: otpError != null
                          ? Container(
                              key: const ValueKey('err'),
                              margin: const EdgeInsets.only(top: 12),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.errorRed.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radius8,
                                ),
                                border: Border.all(
                                  color: AppTheme.errorRed.withOpacity(0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.warning_amber_rounded,
                                    color: AppTheme.errorRed,
                                    size: context.responsiveIconSize(
                                      small: 16,
                                      medium: 18,
                                      large: 20,
                                    ),
                                  ),
                                  SizedBox(width: AppTheme.spacing8),
                                  Expanded(
                                    child: Text(
                                      otpError!,
                                      style: context.responsiveTextStyle(
                                        baseStyle: AppTheme.errorText.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                        fontSizeSmall: AppTheme.fontSize11,
                                        fontSizeMedium: AppTheme.fontSize13,
                                        fontSizeLarge: AppTheme.fontSize16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox(key: ValueKey('no-err')),
                    ),
                    const SizedBox(height: 8),

                    // Resend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive the code? ",
                          style: context.responsiveTextStyle(
                            baseStyle: AppTheme.bodySmall.copyWith(
                              color: AppTheme.textTertiary,
                            ),
                            fontSizeSmall: AppTheme.fontSize11,
                            fontSizeMedium: AppTheme.fontSize13,
                            fontSizeLarge: AppTheme.fontSize16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            onResend();
                          },
                          child: Text(
                            'Resend',
                            style: context.responsiveTextStyle(
                              baseStyle: AppTheme.bodySmall.copyWith(
                                color: AppTheme.primaryRed,
                                fontWeight: FontWeight.w700,
                              ),
                              fontSizeSmall: AppTheme.fontSize11,
                              fontSizeMedium: AppTheme.fontSize13,
                              fontSizeLarge: AppTheme.fontSize16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(height: 1, thickness: 1, color: AppTheme.borderLight),

              // Actions
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: context.responsiveSpacing(
                              small: AppTheme.spacing12,
                              medium: AppTheme.spacing14,
                              large: AppTheme.spacing16,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.radius12,
                            ),
                            side: BorderSide(color: AppTheme.borderLight),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onCancel();
                        },
                        child: Text(
                          'Cancel',
                          style: context.responsiveTextStyle(
                            baseStyle: AppTheme.buttonMedium.copyWith(
                              color: AppTheme.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                            fontSizeSmall: AppTheme.fontSize12,
                            fontSizeMedium: AppTheme.fontSize14,
                            fontSizeLarge: AppTheme.fontSize16,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: Consumer(
                        builder: (context, ref, _) {
                          final isVerifying =
                              ref
                                  .watch(phoneAuthControllerProvider)
                                  .whenOrNull(verifying: () => true) ??
                              false;
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryRed,
                              foregroundColor: AppTheme.textWhite,
                              padding: EdgeInsets.symmetric(
                                vertical: context.responsiveSpacing(
                                  small: AppTheme.spacing12,
                                  medium: AppTheme.spacing14,
                                  large: AppTheme.spacing16,
                                ),
                              ),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radius12,
                                ),
                              ),
                            ),
                            onPressed: isVerifying
                                ? null
                                : () {
                                    final code = getOtpCode();
                                    if (code.length < 6) {
                                      setDialogState(
                                        () => otpError =
                                            'Please enter all 6 digits',
                                      );
                                      return;
                                    }
                                    ref
                                        .read(
                                          phoneAuthControllerProvider.notifier,
                                        )
                                        .verifyOtp(
                                          verificationId: verificationId,
                                          smsCode: code,
                                        );
                                  },
                            child: isVerifying
                                ? SizedBox(
                                    width: context.responsiveIconSize(
                                      small: 16,
                                      medium: 20,
                                      large: 24,
                                    ),
                                    height: context.responsiveIconSize(
                                      small: 16,
                                      medium: 20,
                                      large: 24,
                                    ),
                                    child: CircularProgressIndicator(
                                      color: AppTheme.textWhite,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Verify',
                                        style: context.responsiveTextStyle(
                                          baseStyle: AppTheme.buttonMedium
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme.textWhite,
                                              ),
                                          fontSizeSmall: AppTheme.fontSize12,
                                          fontSizeMedium: AppTheme.fontSize16,
                                          fontSizeLarge: AppTheme.fontSize18,
                                        ),
                                      ),
                                      SizedBox(width: AppTheme.spacing6),
                                      Icon(
                                        Icons.arrow_forward_rounded,
                                        size: context.responsiveIconSize(
                                          small: 14,
                                          medium: 16,
                                          large: 18,
                                        ),
                                        color: AppTheme.textWhite,
                                      ),
                                    ],
                                  ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// ── Error Dialog ──────────────────────────────────────────────────────────────

Future<void> showRegisterErrorDialog({
  required BuildContext context,
  required String message,
  required VoidCallback onRetry,
}) {
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.backgroundWhite,
          borderRadius: BorderRadius.circular(AppTheme.radius20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                color: AppTheme.primaryRed,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(AppTheme.radius20),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.backgroundWhite.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.error_outline_rounded,
                      color: AppTheme.textWhite,
                      size: context.responsiveIconSize(
                        small: 32,
                        medium: 36,
                        large: 40,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveSpacing(
                      small: AppTheme.spacing8,
                      medium: AppTheme.spacing10,
                      large: AppTheme.spacing12,
                    ),
                  ),
                  Text(
                    'Registration Failed',
                    style: context.responsiveTextStyle(
                      baseStyle: AppTheme.h6.copyWith(
                        color: AppTheme.textWhite,
                        letterSpacing: 0.3,
                      ),
                      fontSizeSmall: AppTheme.fontSize16,
                      fontSizeMedium: AppTheme.fontSize18,
                      fontSizeLarge: AppTheme.fontSize20,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: context.responsiveTextStyle(
                  baseStyle: AppTheme.bodyMedium.copyWith(
                    color: AppTheme.textPrimary,
                    height: 1.6,
                  ),
                  fontSizeSmall: AppTheme.fontSize12,
                  fontSizeMedium: AppTheme.fontSize14,
                  fontSizeLarge: AppTheme.fontSize16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
              child: Divider(
                height: AppTheme.spacing24,
                color: AppTheme.borderLight,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                AppTheme.spacing16,
                0,
                AppTheme.spacing16,
                AppTheme.spacing16,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: context.responsiveSpacing(
                            small: AppTheme.spacing12,
                            medium: AppTheme.spacing12,
                            large: AppTheme.spacing14,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radius12,
                          ),
                          side: BorderSide(color: AppTheme.borderLight),
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Dismiss',
                        style: context.responsiveTextStyle(
                          baseStyle: AppTheme.buttonMedium.copyWith(
                            color: AppTheme.textSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                          fontSizeSmall: AppTheme.fontSize12,
                          fontSizeMedium: AppTheme.fontSize14,
                          fontSizeLarge: AppTheme.fontSize16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppTheme.spacing10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryRed,
                        foregroundColor: AppTheme.textWhite,
                        padding: EdgeInsets.symmetric(
                          vertical: context.responsiveSpacing(
                            small: AppTheme.spacing12,
                            medium: AppTheme.spacing12,
                            large: AppTheme.spacing14,
                          ),
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radius12,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        onRetry();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            size: context.responsiveIconSize(
                              small: 14,
                              medium: 16,
                              large: 18,
                            ),
                            color: AppTheme.textWhite,
                          ),
                          SizedBox(width: AppTheme.spacing6),
                          Text(
                            'Try Again',
                            style: context.responsiveTextStyle(
                              baseStyle: AppTheme.buttonMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textWhite,
                              ),
                              fontSizeSmall: AppTheme.fontSize12,
                              fontSizeMedium: AppTheme.fontSize14,
                              fontSizeLarge: AppTheme.fontSize16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
