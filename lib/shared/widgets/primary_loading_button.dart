import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class PrimaryLoadingButton extends StatelessWidget {

  const PrimaryLoadingButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.height = 56,
  });
  final bool isLoading;
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backgroundColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.responsiveValue(small: 45, medium: 50, large: height),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? context.primaryColor,
          foregroundColor: context.textWhiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              context.responsiveValue(small: 8, medium: 10, large: 12),
            ),
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: isLoading
              ? SizedBox(
                  // ignore: always_specify_types
                  key: const ValueKey('loading'),
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
                      context.textWhiteColor,
                    ),
                  ),
                )
              : child,
        ),
      ),
    );
  }
}
