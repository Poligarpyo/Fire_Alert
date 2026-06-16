import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/constants/sg_route.dart';
import '../../../../shared/theme/app_theme.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({super.key, this.onLogout});
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ColoredBox(
        color: context.surfaceColor,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                context.responsiveValue(small: 20, medium: 24, large: 28),
              ),
              decoration: BoxDecoration(color: context.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: context.responsiveValue(
                      small: 40,
                      medium: 50,
                      large: 60,
                    ),
                  ),
                  Text(
                    'Profile Options',
                    style: context
                        .responsiveH3(
                          fontSizeSmall: 18,
                          fontSizeMedium: 20,
                          fontSizeLarge: 22,
                        )
                        .copyWith(color: context.textWhiteColor),
                  ),
                  SizedBox(
                    height: context.responsiveValue(
                      small: 16,
                      medium: 20,
                      large: 24,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  // _buildMenuOption(
                  //   context,
                  //   icon: Icons.edit,
                  //   title: 'Edit Profile',
                  //   subtitle: 'Update your personal information',
                  //   onTap: () =>
                  //       GoRouter.of(context).go(SGRoute.editProfile.route),
                  // ),
                  _buildMenuOption(
                    context,
                    icon: Icons.info_outline,
                    title: 'About',
                    subtitle: 'App version and information',
                    onTap: () => GoRouter.of(context).go(SGRoute.about.route),
                  ),
                  _buildMenuOption(
                    context,
                    icon: Icons.security_outlined,
                    title: 'Privacy Policy',
                    subtitle: 'View our privacy policy',
                    onTap: () =>
                        GoRouter.of(context).go(SGRoute.privacyPolicy.route),
                  ),
                  _buildMenuOption(
                    context,
                    icon: Icons.description_outlined,
                    title: 'Terms and Conditions',
                    subtitle: 'View our terms and conditions',
                    onTap: () => GoRouter.of(
                      context,
                    ).go(SGRoute.termsAndConditions.route),
                  ),
                ],
              ),
            ),

            if (onLogout != null)
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(
                  context.responsiveValue(small: 20, medium: 24, large: 28),
                ),
                child: _buildLogoutButton(context, onLogout!),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.responsiveValue(small: 20, medium: 24, large: 28),
          vertical: context.responsiveValue(small: 12, medium: 16, large: 20),
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: context.responsiveValue(small: 40, medium: 48, large: 56),
              height: context.responsiveValue(small: 40, medium: 48, large: 56),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
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
                children: <Widget>[
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

  Widget _buildLogoutButton(BuildContext context, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: context.responsiveValue(small: 45, medium: 50, large: 56),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.primaryColor,
          foregroundColor: context.textWhiteColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              context.responsiveValue(small: 8, medium: 10, large: 12),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.logout,
              size: context.responsiveIconSize(
                small: 16,
                medium: 18,
                large: 20,
              ),
              color: AppTheme.textWhite,
            ),
            SizedBox(
              width: context.responsiveValue(small: 6, medium: 8, large: 10),
            ),
            Text(
              'Logout',
              style: context.responsiveButtonText(
                fontSizeSmall: 12,
                fontSizeMedium: 14,
                fontSizeLarge: 16,
                color: AppTheme.textWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
