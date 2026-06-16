import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../authentication/presentation/controllers/auth/auth_controller.dart';
import '../controllers/profile_notifier.dart';
import '../controllers/profile_state.dart';
import '../providers/profile_providers.dart';
import '../widgets/profile_info_item.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_header_section.dart';
import '../widgets/profile_menu.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileNotifierProvider.notifier).fetchProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(profileNotifierProvider);

    return Scaffold(
      key: _scaffoldKey,
      appBar: ProfileHeader(
        title: 'Profile',
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
          ),
        ],
      ),
      backgroundColor: context.backgroundColor,
      body: profileState.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.cloud_off_rounded,
                  size: 64,
                  color: context.textSecondaryColor,
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.responsiveBodyText(
                    fontSizeSmall: 14,
                    fontSizeMedium: 15,
                    fontSizeLarge: 16,
                    color: context.textSecondaryColor,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () =>
                      ref.read(profileNotifierProvider.notifier).fetchProfile(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Retry'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primaryColor,
                    foregroundColor: context.textWhiteColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        context.responsiveValue(
                          small: 8,
                          medium: 10,
                          large: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        loaded: (profile) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeaderSection(avatarIcon: Icons.person),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(
                  context.responsiveValue(small: 16, medium: 20, large: 24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: context.responsiveValue(
                        small: 24,
                        medium: 32,
                        large: 40,
                      ),
                    ),
                    ProfileInfoItem(
                      icon: Icons.person,
                      label: 'Name',
                      value: profile.name,
                    ),
                    SizedBox(
                      height: context.responsiveValue(
                        small: 12,
                        medium: 16,
                        large: 20,
                      ),
                    ),
                    ProfileInfoItem(
                      icon: Icons.phone,
                      label: 'Phone Number',
                      value: profile.phone,
                    ),
                    SizedBox(
                      height: context.responsiveValue(
                        small: 12,
                        medium: 16,
                        large: 20,
                      ),
                    ),
                    ProfileInfoItem(
                      icon: Icons.location_on,
                      label: 'Address',
                      value: profile.address,
                    ),
                    SizedBox(
                      height: context.responsiveValue(
                        small: 24,
                        medium: 32,
                        large: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: ProfileMenu(onLogout: () => _showLogoutDialog(context, ref)),
    );
  }

  void _showLogoutDialog(BuildContext context, WidgetRef ref) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Logout',
          style: context.responsiveBodyText(
            fontSizeSmall: 16,
            fontSizeMedium: 18,
            fontSizeLarge: 20,
            color: context.textPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: context.responsiveBodyText(
            fontSizeSmall: 14,
            fontSizeMedium: 15,
            fontSizeLarge: 16,
            color: context.textSecondaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: context.responsiveBodyText(
                fontSizeSmall: 14,
                fontSizeMedium: 15,
                fontSizeLarge: 16,
                color: context.textSecondaryColor,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(authControllerProvider.notifier).logout();
            },
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
            child: Text(
              'Logout',
              style: context.responsiveBodyText(
                fontSizeSmall: 14,
                fontSizeMedium: 15,
                fontSizeLarge: 16,
                color: AppTheme.textWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
