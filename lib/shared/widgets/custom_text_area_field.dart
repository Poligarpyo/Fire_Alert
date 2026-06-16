import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';

class CustomTextAreaField extends StatelessWidget {
  const CustomTextAreaField({
    super.key,
    this.initialValue,
    this.maxLines = 5,
    this.maxLength,
    required this.onChanged,
    required this.hintText,
    this.validator,
    this.inputFormatters,
  });
  final String? initialValue;
  final int maxLines;
  final int? maxLength;
  final Function(String) onChanged;
  final String hintText;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(small: 8, medium: 12, large: 16),
        ),
        border: Border.all(color: AppTheme.borderLight, width: 1),
      ),
      child: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        maxLines: maxLines,
        maxLength: maxLength,
        inputFormatters: inputFormatters,
        style: context.responsiveBodyText(
          fontSizeSmall: 12,
          fontSizeMedium: 14,
          fontSizeLarge: 16,
          color: context.textPrimaryColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: context.responsiveBodyText(
            fontSizeSmall: 11,
            fontSizeMedium: 13,
            fontSizeLarge: 15,
            color: context.textTertiaryColor,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(
            context.responsiveValue(small: 12, medium: 16, large: 20),
          ),
          counterText: '', // hide default counter
        ),
        validator: validator,
      ),
    );
  }
}
