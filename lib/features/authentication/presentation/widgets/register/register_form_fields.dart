// lib/features/authentication/presentation/widgets/register/register_form_fields.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../shared/helper/error_text.dart';
import '../../../../../shared/helper/field_label.dart';
import '../../../../../shared/helper/field_wrapper.dart';
import '../../../../../shared/theme/app_theme.dart';
import '../custom_text_field.dart';

class RegisterFormFields extends StatelessWidget {
  const RegisterFormFields({
    super.key,
    required this.screenHeight,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.passwordController,
    required this.confirmPasswordController,
    this.nameError,
    this.phoneError,
    this.addressError,
    this.passwordError,
    this.confirmPasswordError,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onNameChanged,
    required this.onPhoneChanged,
    required this.onAddressChanged,
    required this.onPasswordChanged,
    required this.onConfirmPasswordChanged,
  });

  final double screenHeight;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? nameError;
  final String? phoneError;
  final String? addressError;
  final String? passwordError;
  final String? confirmPasswordError;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final void Function(String) onNameChanged;
  final void Function(String) onPhoneChanged;
  final void Function(String) onAddressChanged;
  final void Function(String) onPasswordChanged;
  final void Function(String) onConfirmPasswordChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Full Name ──
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: FieldLabel(label: 'Full Name', context: context),
              ),
              TextSpan(
                text: ' *',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                    )
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.errorRed,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        FieldWrapper(
          hasError: nameError != null,
          child: CustomTextField(
            onChanged: onNameChanged, // 👈
            controller: nameController,
            hintText: 'Enter your full name',
            prefixIcon: Icons.person_outline,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            ],
          ),
        ),
        if (nameError != null) ErrorText(message: nameError!, context: context),

        SizedBox(height: screenHeight * 0.025),

        // ── Mobile Number ──
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: FieldLabel(label: 'Mobile Number', context: context),
              ),
              TextSpan(
                text: ' *',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                    )
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.errorRed,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        FieldWrapper(
          hasError: phoneError != null,
          child: CustomTextField(
            onChanged: onPhoneChanged, // 👈
            controller: phoneController,
            hintText: '912 345 6789',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
          ),
        ),
        if (phoneError != null)
          ErrorText(message: phoneError!, context: context),
        SizedBox(height: screenHeight * 0.005),
        Text(
          'For SMS alerts and verification',
          style: context.responsiveBodyText(
            fontSizeSmall: 9,
            fontSizeMedium: 10,
            fontSizeLarge: 12,
            color: context.textTertiaryColor,
          ),
        ),

        SizedBox(height: screenHeight * 0.025),

        // ── Address ──
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: FieldLabel(label: 'Address', context: context),
              ),
              TextSpan(
                text: ' *',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                    )
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.errorRed,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        FieldWrapper(
          hasError: addressError != null,
          child: CustomTextField(
            onChanged: onAddressChanged, // 👈
            controller: addressController,
            hintText: 'Complete home address',
            prefixIcon: Icons.location_on_outlined,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp('[a-zA-Z0-9\\s\\-#/,\\.\\&]'),
              ),
            ],
          ),
        ),
        if (addressError != null)
          ErrorText(message: addressError!, context: context),

        SizedBox(height: screenHeight * 0.025),

        // ── Password ──
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: FieldLabel(label: 'Password', context: context),
              ),
              TextSpan(
                text: ' *',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                    )
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.errorRed,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        FieldWrapper(
          hasError: passwordError != null,
          child: CustomTextField(
            controller: passwordController,
            hintText: 'Enter your password',
            prefixIcon: Icons.lock_outline,
            obscureText: obscurePassword,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};\\|,.<>\/?~`]'),
              ),
            ],
            onChanged: onPasswordChanged,
            suffixIcon: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: context.textTertiaryColor,
                size: context.responsiveIconSize(
                  small: 16,
                  medium: 20,
                  large: 24,
                ),
              ),
              onPressed: onTogglePassword,
            ),
          ),
        ),
        if (passwordError != null)
          ErrorText(message: passwordError!, context: context),

        SizedBox(height: screenHeight * 0.025),

        // ── Confirm Password ──
        Text.rich(
          TextSpan(
            children: [
              WidgetSpan(
                child: FieldLabel(label: 'Confirm Password', context: context),
              ),
              TextSpan(
                text: ' *',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                    )
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.errorRed,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        FieldWrapper(
          hasError: confirmPasswordError != null,
          child: CustomTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm your password',
            prefixIcon: Icons.lock_outline,
            obscureText: obscureConfirmPassword,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};\\|,.<>\/?~`]'),
              ),
            ],
            onChanged: onConfirmPasswordChanged,
            suffixIcon: IconButton(
              icon: Icon(
                obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: context.textTertiaryColor,
                size: context.responsiveIconSize(
                  small: 16,
                  medium: 20,
                  large: 24,
                ),
              ),
              onPressed: onToggleConfirmPassword,
            ),
          ),
        ),
        if (confirmPasswordError != null)
          ErrorText(message: confirmPasswordError!, context: context),
      ],
    );
  }
}
