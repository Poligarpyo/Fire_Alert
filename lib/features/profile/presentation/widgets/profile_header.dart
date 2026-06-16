import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {

  const ProfileHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
  });
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: context.responsiveValue(small: 70, medium: 80, large: 90),
      title: Text(
        title,
        style: context.responsiveBodyText(
          fontSizeSmall: 18,
          fontSizeMedium: 20,
          fontSizeLarge: 22,
          color: context.textWhiteColor,
        ),
      ),
      backgroundColor: context.primaryColor,
      foregroundColor: context.textWhiteColor,
      elevation: 0,
      leading: onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed,
            )
          : null,
      actions: actions,
    );
  }
}
