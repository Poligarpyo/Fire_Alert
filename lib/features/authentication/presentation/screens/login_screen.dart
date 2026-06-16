import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/constants/sg_route.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../offline_sms/presentation/screens/offline_sms_screen.dart';
import '../controllers/auth/auth_controller.dart';
import '../controllers/login/auth_ui_model.dart';
import '../controllers/login/login_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String? _passwordError;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();

    // Validate password
    final password = _passwordController.text.trim();
    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Password is required';
      });
      return;
    }
    if (password.length < 8) {
      setState(() {
        _passwordError = 'Password must be at least 8 characters';
      });
      return;
    }
    setState(() {
      _passwordError = null;
    });

    if (!_formKey.currentState!.validate()) return;

    final phone = _phoneController.text.replaceAll(RegExp(r'[^0-9]'), '');

    try {
      final token = await ref
          .read(loginControllerProvider.notifier)
          .login(phone: phone, password: password);

      // Only proceed if login actually succeeded
      if (token != null) {
        await ref
            .read(authControllerProvider.notifier)
            .loginSuccess(token: token, phone: phone);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginControllerProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;
    final isLargeScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: context.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12.0 : (isLargeScreen ? 24.0 : 14.0),
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.02),
                _buildHeader(screenWidth, screenHeight),
                SizedBox(height: screenHeight * 0.04),
                _buildLoginCard(screenWidth, screenHeight, loginState),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double screenWidth, double screenHeight) {
    final isSmallScreen = screenWidth < 360;
    final isTablet = screenWidth > 600;

    return Column(
      children: [
        Container(
          width: isSmallScreen ? 70 : (isTablet ? 90 : 80),
          height: isSmallScreen ? 70 : (isTablet ? 90 : 80),
          decoration: BoxDecoration(
            color: context.textWhiteColor.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(100)),
          ),
          child: Icon(
            Icons.local_fire_department_rounded,
            size: context.responsiveIconSize(small: 35, medium: 40, large: 45),
            color: context.textWhiteColor,
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        Text(
          'FireAlert System',
          style: context
              .responsiveH1(
                fontSizeSmall: 24,
                fontSizeMedium: 28,
                fontSizeLarge: 32,
              )
              .copyWith(color: context.textWhiteColor),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          'GPS-Based Emergency Response Platform',
          textAlign: TextAlign.center,
          style: context.responsiveBodyText(
            fontSizeSmall: 12,
            fontSizeMedium: 14,
            fontSizeLarge: 16,
            color: context.textWhiteColor.withOpacity(0.7),
          ),
        ),
        SizedBox(height: screenHeight * 0.02),
        GestureDetector(
          onTap: () => showDialog<void>(
            context: context,
            builder: (_) => const OfflineSmsScreen(),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: context.secondaryColor,
              borderRadius: BorderRadius.circular(
                context.responsiveValue(small: 8, medium: 10, large: 12),
              ),
            ),
            width: double.infinity,
            height: context.responsiveValue(small: 50, medium: 60, large: 70),
            child: Row(
              children: [
                SizedBox(width: isSmallScreen ? 6 : 8),
                Icon(
                  Icons.phone_android,
                  color: context.errorColor,
                  size: context.responsiveIconSize(
                    small: 16,
                    medium: 20,
                    large: 24,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Emergency SMS Report\n(No Account Needed)',
                      textAlign: TextAlign.center,
                      style: context.responsiveButtonText(
                        fontSizeSmall: 12,
                        fontSizeMedium: 14,
                        fontSizeLarge: 16,
                        color: context.errorColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginCard(
    double screenWidth,
    double screenHeight,
    AuthUiModel loginState,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Citizen Login',
                    style: context
                        .responsiveH3(
                          fontSizeSmall: 18,
                          fontSizeMedium: 20,
                          fontSizeLarge: 22,
                        )
                        .copyWith(color: context.textPrimaryColor),
                  ),
                  TextButton.icon(
                    onPressed: () => context.go(SGRoute.register.route),
                    icon: Icon(
                      Icons.person_add_outlined,
                      size: context.responsiveIconSize(
                        small: 14,
                        medium: 16,
                        large: 18,
                      ),
                      color: context.errorColor,
                    ),
                    label: Text(
                      'Create Account',
                      style: context.responsiveButtonText(
                        fontSizeSmall: 10,
                        fontSizeMedium: 12,
                        fontSizeLarge: 14,
                        color: context.errorColor,
                      ),
                    ),
                  ),
                ],
              ),

              if (loginState.errorMessage != null) ...[
                SizedBox(height: screenHeight * 0.01),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: context.errorColor.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.errorColor.withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    loginState.errorMessage!,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 11,
                      fontSizeMedium: 12,
                      fontSizeLarge: 13,
                      color: context.errorColor,
                    ),
                  ),
                ),
              ],

              SizedBox(height: screenHeight * 0.025),

              Text(
                'Mobile Number',
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
                onChanged: (value) {
                  if (_formKey.currentState != null) {
                    _formKey.currentState!.validate();
                  }
                },
              ),
              Text(
                'For SMS alerts and verification',
                style: context.responsiveBodyText(
                  fontSizeSmall: 9,
                  fontSizeMedium: 10,
                  fontSizeLarge: 12,
                  color: context.textTertiaryColor,
                ),
              ),

              SizedBox(height: screenHeight * 0.015),

              Text(
                'Password',
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
                hintText: 'Enter your password',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};\\|,.<>\/?~`]'),
                  ),
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
                onChanged: (value) {
                  if (_passwordError != null && value.isNotEmpty) {
                    setState(() {
                      _passwordError = null;
                    });
                  }
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

              SizedBox(height: screenHeight * 0.03),

              CustomButton(
                text: 'Login as Citizen',
                textColor: AppTheme.textWhite,
                backgroundColor: AppTheme.primaryRed,
                icon: Icons.login,
                onPressed: _handleLogin,
                isLoading: loginState.isLoading,
              ),
              SizedBox(height: screenHeight * 0.015),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => context.go(SGRoute.forgotPassword.route),
                  child: Text(
                    'Forgot Password?',
                    style: context.responsiveButtonText(
                      fontSizeSmall: 11,
                      fontSizeMedium: 13,
                      fontSizeLarge: 14,
                      color: context.errorColor,
                    ),
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
