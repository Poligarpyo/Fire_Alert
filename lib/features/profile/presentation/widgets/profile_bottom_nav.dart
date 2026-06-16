import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/constants/sg_route.dart';
import '../../../../shared/theme/app_theme.dart';

class ProfileBottomNav extends StatelessWidget {
  const ProfileBottomNav({super.key, this.currentIndex = 2});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: context.backgroundColor,
        selectedItemColor: context.primaryColor,
        unselectedItemColor: context.textSecondaryColor,
        selectedFontSize: context.responsiveValue(
          small: 10,
          medium: 11,
          large: 12,
        ),
        unselectedFontSize: context.responsiveValue(
          small: 9,
          medium: 10,
          large: 11,
        ),
        iconSize: context.responsiveIconSize(small: 20, medium: 22, large: 24),
        elevation: 0,
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              GoRouter.of(context).go(SGRoute.reportIncident.route);
              break;
            case 1:
              GoRouter.of(context).go(SGRoute.reportsHistory.route);
              break;
            case 2:
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.warning_outlined),
            activeIcon: Icon(Icons.warning),
            label: 'Incident',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            activeIcon: Icon(Icons.list_alt),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            activeIcon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
