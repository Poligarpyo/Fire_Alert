import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/provider/speed_test_provider.dart';
import '../../../../data/enums/connection_quality.dart';
import '../../../../shared/theme/app_theme.dart';

class InternetSpeedRealtime extends ConsumerStatefulWidget {
  const InternetSpeedRealtime({super.key});

  @override
  ConsumerState<InternetSpeedRealtime> createState() =>
      _InternetSpeedRealtimeState();
}

class _InternetSpeedRealtimeState extends ConsumerState<InternetSpeedRealtime> {
  @override
  Widget build(BuildContext context) {
    final speedAsync = ref.watch(speedTestProvider);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final position = ref.watch(speedBadgePositionProvider);

    final dx = position.dx == double.infinity ? screenWidth - 120 : position.dx;
    final dy = position.dy;

    return Positioned(
      left: dx,
      top: dy,
      child: GestureDetector(
        onTap: () => ref.read(speedTestRefreshProvider.notifier).state++,
        onPanUpdate: (details) {
          final current = ref.read(speedBadgePositionProvider);
          final newDx =
              (current.dx == double.infinity ? screenWidth - 120 : current.dx) +
              details.delta.dx;
          final newDy = current.dy + details.delta.dy;

          ref.read(speedBadgePositionProvider.notifier).state = Offset(
            newDx.clamp(0, screenWidth - 120),
            newDy.clamp(MediaQuery.paddingOf(context).top, screenHeight - 100),
          );
        },
        child: speedAsync.when(
          data: (pingMs) => _PingBadge(pingMs: pingMs),
          loading: () => const _LoadingBadge(),
          error: (_, __) => GestureDetector(
            onTap: () => ref.invalidate(speedTestProvider),
            child: const _ErrorBadge(),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Badge sub-widgets
// -----------------------------------------------------------------------------

class _PingBadge extends ConsumerWidget {
  const _PingBadge({required this.pingMs});

  final double pingMs;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quality = ref.read(speedTestServiceProvider).classify(pingMs);

    final (color, icon, label) = switch (quality) {
      ConnectionQuality.excellent => (
        AppTheme.successGreen,
        Icons.signal_wifi_4_bar,
        'Excellent',
      ),
      ConnectionQuality.good => (
        AppTheme.warningYellow,
        Icons.network_wifi,
        'Good',
      ),
      ConnectionQuality.poor => (
        AppTheme.secondaryOrange,
        Icons.network_wifi_2_bar,
        'Poor',
      ),
      ConnectionQuality.offline => (
        AppTheme.errorRed,
        Icons.wifi_off,
        'Offline',
      ),
      _ => (AppTheme.textSecondary, Icons.wifi_off, 'Unknown'),
    };

    return _BadgeShell(
      children: [
        Icon(icon, color: color, size: 13),
        const SizedBox(width: 6),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pingMs >= 9999 ? 'No Signal' : '${pingMs}ms',
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                color: AppTheme.textWhite.withOpacity(0.38),
                fontSize: 9,
                height: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(width: 4),
        Icon(
          Icons.drag_indicator,
          color: AppTheme.textWhite.withOpacity(0.24),
          size: 11,
        ),
      ],
    );
  }
}

class _LoadingBadge extends StatelessWidget {
  const _LoadingBadge();

  @override
  Widget build(BuildContext context) {
    return _BadgeShell(
      children: [
        SizedBox(
          width: 12,
          height: 12,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            color: AppTheme.textWhite.withOpacity(0.54),
          ),
        ),
        SizedBox(width: 6),
        Text(
          'Testing...',
          style: TextStyle(
            color: AppTheme.textWhite.withOpacity(0.38),
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

class _ErrorBadge extends StatelessWidget {
  const _ErrorBadge();

  @override
  Widget build(BuildContext context) {
    return _BadgeShell(
      children: [
        Icon(Icons.wifi_off, color: AppTheme.textSecondary, size: 13),
        SizedBox(width: 5),
        Text(
          'Tap to retry',
          style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
        ),
      ],
    );
  }
}

class _BadgeShell extends StatelessWidget {
  const _BadgeShell({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.65),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: children),
    );
  }
}
