import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class CustomTextFormField extends StatelessWidget {

  const CustomTextFormField({
    super.key,
    required this.onChanged,
    required this.hintText,
    this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    required this.inputFormatters,
    this.validator,
  });
  final void Function(String) onChanged;
  final String hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 8, medium: 12, large: 16),
        ),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: TextFormField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: context.responsiveBodyText(
          fontSizeSmall: 13,
          fontSizeMedium: 15,
          fontSizeLarge: 17,
          color: context.textPrimaryColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.responsiveBodyText(
            fontSizeSmall: 13,
            fontSizeMedium: 15,
            fontSizeLarge: 17,
            color: context.textTertiaryColor,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: context.textTertiaryColor,
                  size: context.responsiveIconSize(
                    small: 18,
                    medium: 20,
                    large: 22,
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.responsiveValue(
              small: 12,
              medium: 16,
              large: 20,
            ),
            vertical: context.responsiveValue(small: 12, medium: 16, large: 20),
          ),
        ),
        inputFormatters: inputFormatters,
        validator: validator,
      ),
    );
  }
}
