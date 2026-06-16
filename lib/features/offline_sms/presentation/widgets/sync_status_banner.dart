import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/offline_sms/notifier.dart';

/// Animated banner inside the dialog, below [HeaderSmsOffline].
///
/// - Green  → reports synced (auto-dismissed by notifier after 2s)
/// - Amber  → back online, sync in progress
/// - Hidden → nothing pending
class SyncStatusBanner extends ConsumerStatefulWidget {
  const SyncStatusBanner({super.key});

  @override
  ConsumerState<SyncStatusBanner> createState() => _SyncStatusBannerState();
}

class _SyncStatusBannerState extends ConsumerState<SyncStatusBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _sizeFactor;
  bool _wasVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 260),
      vsync: this,
    );
    _sizeFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateVisibility(bool shouldShow) {
    if (shouldShow && !_wasVisible) {
      _wasVisible = true;
      _controller.forward();
    } else if (!shouldShow && _wasVisible) {
      _wasVisible = false;
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final syncedCount = ref.watch(
      offlineSmsNotifierProvider.select((s) => s.syncedCount),
    );
    final hasPendingSync = ref.watch(
      offlineSmsNotifierProvider.select((s) => s.hasPendingSync),
    );

    final isSuccess = syncedCount > 0;
    final shouldShow = isSuccess || hasPendingSync;

    _updateVisibility(shouldShow);

    final bgColor = isSuccess ? Colors.green.shade50 : Colors.amber.shade50;
    final borderColor =
        isSuccess ? Colors.green.shade300 : Colors.amber.shade300;
    final iconColor =
        isSuccess ? Colors.green.shade700 : Colors.amber.shade800;
    final textColor =
        isSuccess ? Colors.green.shade900 : Colors.amber.shade900;
    final icon =
        isSuccess ? Icons.cloud_done_outlined : Icons.cloud_off_outlined;
    final message = isSuccess
        ? '$syncedCount pending report(s) synced successfully.'
        : 'Back online — syncing pending messages…';

    return SizeTransition(
      sizeFactor: _sizeFactor,
      axisAlignment: -1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: bgColor,
          border: Border(bottom: BorderSide(color: borderColor, width: 0.5)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 16, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 13, color: textColor, height: 1.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}