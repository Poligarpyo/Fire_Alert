import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

class ProfileInfoItem extends StatelessWidget {

  const ProfileInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(
          context.responsiveValue(
            small: 12,
            medium: 16,
            large: 20,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(
          context.responsiveValue(small: 16, medium: 20, large: 24),
        ),
        child: Row(
          children: [
            Container(
              width: context.responsiveValue(small: 40, medium: 48, large: 56),
              height: context.responsiveValue(small: 40, medium: 48, large: 56),
              decoration: BoxDecoration(
                color: context.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                  context.responsiveValue(small: 8, medium: 10, large: 12),
                ),
              ),
              child: Icon(
                icon,
                size: context.responsiveIconSize(
                  small: 20,
                  medium: 24,
                  large: 28,
                ),
                color: context.primaryColor,
              ),
            ),
            SizedBox(
              width: context.responsiveValue(small: 12, medium: 16, large: 20),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 12,
                      fontSizeMedium: 13,
                      fontSizeLarge: 14,
                      color: context.textSecondaryColor,
                    ),
                  ),
                  SizedBox(
                    height: context.responsiveValue(
                      small: 2,
                      medium: 3,
                      large: 4,
                    ),
                  ),
                  Text(
                    value,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 14,
                      fontSizeMedium: 16,
                      fontSizeLarge: 18,
                      color: context.textPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
