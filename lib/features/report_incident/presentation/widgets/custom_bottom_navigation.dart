import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../shared/constants/sg_route.dart';
import '../../../../shared/theme/app_theme.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SalomonBottomBar(
      currentIndex: currentIndex,
      onTap: (index) async {
        await Future<void>.delayed(const Duration(milliseconds: 100));

        switch (index) {
          case 0:
            if (currentIndex != 0) {
              GoRouter.of(context).go(SGRoute.reportIncident.route);
            }
            break;
          case 1:
            if (currentIndex != 1) {
              GoRouter.of(context).go(SGRoute.reportsHistory.route);
            }
            break;
          case 2:
            if (currentIndex != 2) {
              GoRouter.of(context).go(SGRoute.accountInfo.route);
            }
            break;
        }
      },
      items: [
        SalomonBottomBarItem(
          icon: const Icon(Icons.warning),
          title: const Text('Incident'),
          selectedColor: AppTheme.textWhite,
          unselectedColor: AppTheme.textWhite.withOpacity(0.6),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.list_alt),
          title: const Text('History'),
          selectedColor: AppTheme.textWhite,
          unselectedColor: AppTheme.textWhite.withOpacity(0.6),
        ),
        SalomonBottomBarItem(
          icon: const Icon(Icons.account_circle),
          title: const Text('Profile'),
          selectedColor: AppTheme.textWhite,
          unselectedColor: AppTheme.textWhite.withOpacity(0.6),
        ),
      ],
      backgroundColor: AppTheme.primaryRed,
      curve: Curves.easeOutCubic,
      duration: const Duration(milliseconds: 400),
      itemShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      itemPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
    );
  }
}
