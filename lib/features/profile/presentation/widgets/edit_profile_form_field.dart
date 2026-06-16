import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../authentication/presentation/widgets/custom_text_field.dart';

class EditProfileFormField extends StatelessWidget {
  const EditProfileFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.errorText,
    this.subtitle,
    required FocusNode focusNode,
  });
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final String? errorText;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: context.responsiveBodyText(
            fontSizeSmall: 12,
            fontSizeMedium: 14,
            fontSizeLarge: 16,
            color: context.textSecondaryColor,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: errorText != null
                  ? context.errorColor
                  : Colors.transparent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomTextField(
            controller: controller,
            hintText: hintText,
            prefixIcon: prefixIcon,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters ?? [],
            validator: validator,
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              errorText!,
              style: context.responsiveBodyText(
                fontSizeSmall: 10,
                fontSizeMedium: 11,
                fontSizeLarge: 12,
                color: context.errorColor,
              ),
            ),
          ),
        if (subtitle != null) ...[
          SizedBox(height: screenHeight * 0.01),
          Text(
            subtitle!,
            style: context.responsiveBodyText(
              fontSizeSmall: 9,
              fontSizeMedium: 10,
              fontSizeLarge: 12,
              color: context.textTertiaryColor,
            ),
          ),
        ],
      ],
    );
  }
}
