import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/sg_route.dart';
import '../../../../shared/theme/app_theme.dart';
import '../controllers/login/reset_password_controller.dart';
import '../controllers/login/reset_password_ui_model.dart';
import '../controllers/register/phone_auth_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/register/register_dialogs.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String? _passwordError;
  String? _pendingPhone;
  String? _pendingPassword;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String _normalizePhoneNumber(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.startsWith('+63')) {
      return '+63${digits.substring(3)}';
    }
    if (digits.startsWith('63')) {
      return '+$digits';
    }
    if (digits.startsWith('0')) {
      return '+63${digits.substring(1)}';
    }
    return '+63$digits';
  }

  String _formatPhoneForDialog(String phone) {
    final digits = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digits.startsWith('+63')) {
      return digits.substring(3);
    }
    if (digits.startsWith('63')) {
      return digits.substring(2);
    }
    if (digits.startsWith('0')) {
      return digits.substring(1);
    }
    return digits;
  }

  Future<void> _handleResetPassword() async {
    _passwordError = null;
    final String phone = _phoneController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (!_formKey.currentState!.validate()) return;

    if (password != confirmPassword) {
      setState(() {
        _passwordError = 'Passwords do not match';
      });
      return;
    }

    setState(() {
      _passwordError = null;
    });

    final String normalizedPhone = _normalizePhoneNumber(phone);
    _pendingPhone = normalizedPhone;
    _pendingPassword = password;

    await ref
        .read(phoneAuthControllerProvider.notifier)
        .sendOtp(normalizedPhone);
  }

  Future<void> _submitResetPassword() async {
    if (_pendingPhone == null || _pendingPassword == null) return;

    final bool success = await ref
        .read(resetPasswordControllerProvider.notifier)
        .resetPassword(
          phone: _pendingPhone!,
          password: _pendingPassword!,
        );

    if (success && mounted) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password has been reset successfully.'),
        ),
      );
      context.go(SGRoute.login.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ResetPasswordUiModel uiState =
        ref.watch<ResetPasswordUiModel>(resetPasswordControllerProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;
    final isLargeScreen = screenWidth > 600;

ref.listen<PhoneAuthState>(
        phoneAuthControllerProvider,
        (PhoneAuthState? previous, PhoneAuthState next) {
          next.when(
            initial: () {},
            sendingOtp: () {},
            otpSent: (String verificationId) {
              if (!mounted) return;
              showOtpDialog(
                context: context,
                ref: ref,
                verificationId: verificationId,
                phoneNumber: _pendingPhone != null
                    ? _formatPhoneForDialog(_pendingPhone!)
                    : _phoneController.text.trim(),
                onResend: () {
                  if (_pendingPhone != null) {
                    ref
                        .read(phoneAuthControllerProvider.notifier)
                        .sendOtp(_pendingPhone!);
                  }
                },
                onCancel: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
              );
            },
            verifying: () {},
            success: () {
              _submitResetPassword();
            },
            error: (String message) {
              if (!mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
          );
        },
      );

    return Scaffold(
      backgroundColor: context.primaryColor,
      appBar: AppBar(
        title: const Text('Forgot Password'),
        backgroundColor: context.primaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12.0 : (isLargeScreen ? 24.0 : 14.0),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Reset your password using your registered phone number.',
                  textAlign: TextAlign.center,
                  style: context.responsiveBodyText(
                    fontSizeSmall: 12,
                    fontSizeMedium: 14,
                    fontSizeLarge: 16,
                    color: context.textWhiteColor.withOpacity(0.85),
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                _buildResetCard(screenWidth, screenHeight, uiState),
                SizedBox(height: screenHeight * 0.03),
                TextButton(
                  onPressed: () => context.go(SGRoute.login.route),
                  child: Text(
                    'Back to login',
                    style: context.responsiveButtonText(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                      color: context.textWhiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetCard(
    double screenWidth,
    double screenHeight,
    ResetPasswordUiModel uiState,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 16, medium: 20, large: 24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          context.responsiveValue(small: 16, medium: 20, large: 24),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Forgot Password',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 18,
                      fontSizeMedium: 20,
                      fontSizeLarge: 22,
                    )
                    .copyWith(color: context.textPrimaryColor),
              ),
              SizedBox(height: screenHeight * 0.03),
              Text(
                'Phone Number',
                style: context.responsiveBodyText(
                  fontSizeSmall: 10,
                  fontSizeMedium: 12,
                  fontSizeLarge: 14,
                  color: context.textSecondaryColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                controller: _phoneController,
                hintText: '912 345 6789',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  final phone = value?.trim() ?? '';
                  if (phone.isEmpty) return 'Phone number is required';
                  if (!phone.startsWith('9')) {
                    return 'Must start with 9 (e.g. 9123456789)';
                  }
                  if (phone.length != 10) {
                    return 'Enter a valid 10-digit number';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'New Password',
                style: context.responsiveBodyText(
                  fontSizeSmall: 10,
                  fontSizeMedium: 12,
                  fontSizeLarge: 14,
                  color: context.textSecondaryColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                controller: _passwordController,
                hintText: 'Enter new password',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9!@#\$%\^&*()_+\-=\[\]{};\\|,.<>\/\?~`]'),
                  ),
                  LengthLimitingTextInputFormatter(8),
                ],
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: context.textSecondaryColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                validator: (value) {
                  final password = value?.trim() ?? '';
                  if (password.isEmpty) return 'Password is required';
                  if (password.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Confirm Password',
                style: context.responsiveBodyText(
                  fontSizeSmall: 10,
                  fontSizeMedium: 12,
                  fontSizeLarge: 14,
                  color: context.textSecondaryColor,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              CustomTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm new password',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9!@#\$%\^&*()_+\-=\[\]{};\\|,.<>\/\?~`]'),
                  ),
                  LengthLimitingTextInputFormatter(8),
                ],
                validator: (value) {
                  final password = value?.trim() ?? '';
                  if (password.isEmpty) return 'Confirm password is required';
                  return null;
                },
              ),
              if (_passwordError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _passwordError!,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 10,
                      fontSizeMedium: 11,
                      fontSizeLarge: 12,
                      color: context.errorColor,
                    ),
                  ),
                ),
              if (uiState.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    uiState.errorMessage!,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 10,
                      fontSizeMedium: 11,
                      fontSizeLarge: 12,
                      color: context.errorColor,
                    ),
                  ),
                ),
              SizedBox(height: screenHeight * 0.03),
              CustomButton(
                text: 'Reset Password',
                textColor: AppTheme.textWhite,
                backgroundColor: AppTheme.primaryRed,
                icon: Icons.lock_reset,
                onPressed: _handleResetPassword,
                isLoading: uiState.isLoading,
              ),
              if (uiState.successMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    uiState.successMessage!,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 11,
                      fontSizeMedium: 12,
                      fontSizeLarge: 13,
                      color: AppTheme.successGreen,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
