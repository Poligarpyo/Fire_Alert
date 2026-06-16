import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/speed_test_provider.dart';
import '../../../../data/enums/connection_quality.dart';
import '../../../../shared/helper/offline_screen.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../../history_report/presentation/screens/reports_history_page.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../report_incident/presentation/screens/report_incident_screen.dart';
import '../../../report_incident/presentation/widgets/send_button.dart';
import '../providers/select_provider.dart';
import '../widgets/internet_speed_realtime.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  static final List<Widget> _screens = [
    const ReportIncidentScreen(),
    const ReportsHistoryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<double>>(speedTestProvider, (_, next) {
      final pingMs = next.error == null && !next.isLoading ? next.value : null;
      if (pingMs == null) return;

      final quality = ref.read(speedTestServiceProvider).classify(pingMs);

      final isShowing = ref.read(isOfflineDialogShowingProvider);
      if (isShowing) return;

      if (quality == ConnectionQuality.poor ||
          quality == ConnectionQuality.offline) {
        ref.read(isOfflineDialogShowingProvider.notifier).state = true;

        WidgetsBinding.instance.addPostFrameCallback((_) async {
          await showOfflineSMSDialog(context);
          ref.read(isOfflineDialogShowingProvider.notifier).state = false;
        });
      }
    });

    final selectedIndex = ref.watch(selectedTabProvider);

    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: selectedIndex, children: _screens),
          const InternetSpeedRealtime(),
        ],
      ),
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(
          color: context.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selectedIndex == 0)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.responsiveValue(
                    small: 16,
                    medium: 20,
                    large: 24,
                  ),
                  vertical: context.responsiveValue(
                    small: 10,
                    medium: 12,
                    large: 14,
                  ),
                ),
                child: const SendButton(),
              ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: context.textTertiaryColor.withOpacity(0.2),
                    width: 1,
                  ),
                ),
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
                iconSize: context.responsiveIconSize(
                  small: 20,
                  medium: 22,
                  large: 24,
                ),
                elevation: 0,
                currentIndex: selectedIndex,
                onTap: (index) =>
                    ref.read(selectedTabProvider.notifier).state = index,
                items: const [
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
            ),
          ],
        ),
      ),
    );
  }
}
