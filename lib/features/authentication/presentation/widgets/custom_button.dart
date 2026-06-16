import 'package:flutter/material.dart';

import '../../../../shared/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.responsiveValue(small: 45, medium: 50, large: 56),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? context.primaryColor,
          foregroundColor: textColor ?? context.textWhiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              context.responsiveValue(small: 8, medium: 10, large: 12),
            ),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: context.responsiveIconSize(
                  small: 16,
                  medium: 18,
                  large: 20,
                ),
                width: context.responsiveIconSize(
                  small: 16,
                  medium: 18,
                  large: 20,
                ),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    textColor ?? context.textWhiteColor,
                  ),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: context.responsiveIconSize(
                        small: 16,
                        medium: 18,
                        large: 20,
                      ),
                    ),
                    SizedBox(
                      width: context.responsiveValue(
                        small: 6,
                        medium: 8,
                        large: 10,
                      ),
                    ),
                  ],
                  Text(
                    text,
                    style: context.responsiveButtonText(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                      color: textColor ?? context.textWhiteColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
