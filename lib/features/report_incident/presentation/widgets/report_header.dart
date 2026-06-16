import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../profile/presentation/providers/profile_providers.dart';

import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/theme/app_theme.dart';
import 'shimmer/shimmer_loading_widget.dart';

class ReportHeader extends ConsumerWidget implements PreferredSizeWidget {
  const ReportHeader({super.key});

  @override
  Size get preferredSize => Size.fromHeight(160); // Will be made responsive in build

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(currentProfileProvider);
    return AppBar(
      toolbarHeight: context.responsiveValue(
        small: 140,
        medium: 160,
        large: 180,
      ),
      flexibleSpace: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: AppColors.primaryRed),
        child: Padding(
          padding: EdgeInsets.only(
            left: context.responsiveValue(small: 16, medium: 20, large: 24),
            right: context.responsiveValue(small: 16, medium: 20, large: 24),
            top: context.responsiveValue(small: 44, medium: 48, large: 52),
            bottom: context.responsiveValue(small: 12, medium: 16, large: 20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: context.responsiveValue(small: 2, medium: 4, large: 6),
                ),
                child: Row(
                  children: [
                    Container(
                      width: context.responsiveValue(
                        small: 32,
                        medium: 40,
                        large: 48,
                      ),
                      height: context.responsiveValue(
                        small: 32,
                        medium: 40,
                        large: 48,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.textWhite.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: AppTheme.textWhite,
                        size: context.responsiveIconSize(
                          small: 18,
                          medium: 24,
                          large: 30,
                        ),
                      ),
                    ),

                    SizedBox(
                      width: context.responsiveValue(
                        small: 8,
                        medium: 12,
                        large: 16,
                      ),
                    ),

                    Expanded(
                      child: profileAsync.when(
                        loading: () => _buildShimmerUserInfo(context),
                        error: (_, _) => _buildUserInfo(context),
                        data: (profile) => _buildUserInfo(
                          context,
                          name: profile.name,
                          phone: profile.phone,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: context.responsiveValue(
                  small: 12,
                  medium: 16,
                  large: 20,
                ),
              ),

              Text(
                'Report Fire Incident',
                style: context
                    .responsiveH3(
                      fontSizeSmall: 20,
                      fontSizeMedium: 24,
                      fontSizeLarge: 28,
                    )
                    .copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textWhite,
                    ),
              ),

              SizedBox(
                height: context.responsiveValue(small: 2, medium: 4, large: 6),
              ),

              Text(
                'Your location is being tracked',
                style: context
                    .responsiveBodyText(
                      fontSizeSmall: 12,
                      fontSizeMedium: 14,
                      fontSizeLarge: 16,
                    )
                    .copyWith(color: AppTheme.textWhite),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildShimmerUserInfo(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ShimmerTextWidget(
        width: context.responsiveValue(small: 100, medium: 120, large: 140),
        height: context.responsiveValue(small: 14, medium: 16, large: 18),
      ),
      SizedBox(height: context.responsiveValue(small: 2, medium: 4, large: 6)),
      ShimmerTextWidget(
        width: context.responsiveValue(small: 60, medium: 80, large: 100),
        height: context.responsiveValue(small: 10, medium: 12, large: 14),
      ),
    ],
  );
}

Widget _buildUserInfo(
  BuildContext context, {
  String name = 'User',
  String phone = '',
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
        style: context
            .responsiveBodyText(
              fontSizeSmall: 12,
              fontSizeMedium: 14,
              fontSizeLarge: 16,
            )
            .copyWith(fontWeight: FontWeight.w600, color: AppTheme.textWhite),
      ),
      Text(
        phone.isNotEmpty ? phone : 'Mobile User',
        style: context
            .responsiveBodyText(
              fontSizeSmall: 10,
              fontSizeMedium: 12,
              fontSizeLarge: 14,
            )
            .copyWith(color: AppTheme.textWhite.withOpacity(0.7)),
      ),
    ],
  );
}
