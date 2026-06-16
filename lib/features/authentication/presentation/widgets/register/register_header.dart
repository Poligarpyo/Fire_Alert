import 'package:flutter/material.dart'; 
import '../../../../../shared/theme/app_theme.dart'; 
import '../../../../offline_sms/presentation/screens/offline_sms_screen.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  final double screenWidth;
  final double screenHeight;

  @override
  Widget build(BuildContext context) {
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
              .responsiveH1(fontSizeSmall: 24, fontSizeMedium: 28, fontSizeLarge: 32)
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
          onTap: () => showDialog(
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
                SizedBox(width: context.isSmallScreen ? 6 : 8),
                Icon(
                  Icons.local_fire_department,
                  color: context.errorColor,
                  size: context.responsiveIconSize(small: 16, medium: 20, large: 24),
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
}