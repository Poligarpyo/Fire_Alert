import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import 'profile_avatar.dart';

class ProfileHeaderSection extends StatelessWidget {

  const ProfileHeaderSection({super.key, this.avatarIcon, this.child});
  final IconData? avatarIcon;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: context.responsiveValue(small: 20, medium: 24, large: 28),
        right: context.responsiveValue(small: 20, medium: 24, large: 28),
        bottom: context.responsiveValue(small: 20, medium: 24, large: 28),
        top: context.responsiveValue(small: 4, medium: 6, large: 8),
      ),
      decoration: BoxDecoration(
        color: context.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (avatarIcon != null)
            ProfileAvatar(icon: avatarIcon)
          else if (child != null)
            child!,
        ],
      ),
    );
  }
}
