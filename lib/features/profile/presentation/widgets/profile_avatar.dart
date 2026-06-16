import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';

class ProfileAvatar extends StatelessWidget {

  const ProfileAvatar({super.key, this.size, this.icon, this.backgroundImage});
  final double? size;
  final IconData? icon;
  final String? backgroundImage;

  @override
  Widget build(BuildContext context) {
    final avatarSize =
        size ?? context.responsiveValue(small: 120, medium: 140, large: 160);

    return Container(
      width: avatarSize,
      height: avatarSize,
      decoration: BoxDecoration(
        color: context.textWhiteColor,
        borderRadius: BorderRadius.circular(avatarSize / 2),
        border: Border.all(color: context.textWhiteColor, width: 3),
      ),
      child: backgroundImage != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(avatarSize / 2),
              child: Image.network(
                backgroundImage!,
                width: avatarSize,
                height: avatarSize,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    icon ?? Icons.person,
                    size: avatarSize * 0.5,
                    color: context.primaryColor,
                  );
                },
              ),
            )
          : Icon(
              icon ?? Icons.person,
              size: avatarSize * 0.5,
              color: context.primaryColor,
            ),
    );
  }
}
