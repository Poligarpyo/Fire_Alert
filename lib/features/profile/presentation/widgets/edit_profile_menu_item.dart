import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

class EditProfileMenuItem extends StatelessWidget {

  const EditProfileMenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(small: 20, medium: 24, large: 28),
          vertical: context.responsiveValue(small: 12, medium: 16, large: 20),
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
                    title,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 14,
                      fontSizeMedium: 16,
                      fontSizeLarge: 18,
                      color: context.textPrimaryColor,
                      fontWeight: FontWeight.w500,
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
                    subtitle,
                    style: context.responsiveBodyText(
                      fontSizeSmall: 12,
                      fontSizeMedium: 13,
                      fontSizeLarge: 14,
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: context.textTertiaryColor,
              size: context.responsiveIconSize(
                small: 16,
                medium: 18,
                large: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
