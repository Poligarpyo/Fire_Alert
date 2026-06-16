import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/common/navigation_keys.dart';
import '../controllers/offline_sms/notifier.dart';
import '../controllers/offline_sms/state.dart';

/// Global listener for offline SMS state side-effects.
///
/// Wraps the widget tree above the dialog so snackbars and pops can be
/// triggered via [rootNavigatorKey] / [scaffoldMessengerKey] regardless
/// of which screen is currently active.
class OfflineSmsListener extends ConsumerWidget {
  const OfflineSmsListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<OfflineSmsState>(offlineSmsNotifierProvider, (prev, next) {
      // ── Cancel ────────────────────────────────────────────────────────────
      if (next.shouldCloseDialog && !(prev?.shouldCloseDialog ?? false)) {
        rootNavigatorKey.currentState?.pop();
        ref.read(offlineSmsNotifierProvider.notifier).resetCloseDialog();
        return;
      }

      // ── Success ───────────────────────────────────────────────────────────
      if (next.success && !(prev?.success ?? false)) {
        rootNavigatorKey.currentState?.pop();
        scaffoldMessengerKey.currentState?.showSnackBar(
          _snackBar(
            message: 'Emergency SMS sent successfully.',
            icon: Icons.check_circle_outline_rounded,
            color: Colors.green.shade700,
          ),
        );
        ref.read(offlineSmsNotifierProvider.notifier).resetStatus();
        return;
      }

      // ── Sync complete ─────────────────────────────────────────────────────
      if (next.syncedCount > 0 && (prev?.syncedCount ?? 0) == 0) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          _snackBar(
            message: '${next.syncedCount} pending report(s) synced to server.',
            icon: Icons.cloud_done_outlined,
            color: Colors.blue.shade700,
          ),
        );
        return;
      }

      // ── Back online, nothing to sync ──────────────────────────────────────
      // hasPendingSync flips false after sync completes with 0 pending.
      if (!(next.hasPendingSync) &&
          (prev?.hasPendingSync ?? false) &&
          next.syncedCount == 0) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          _snackBar(
            message: 'Back online. No pending reports.',
            icon: Icons.wifi_rounded,
            color: Colors.blueGrey.shade700,
          ),
        );
        return;
      }

      // ── Error ─────────────────────────────────────────────────────────────
      if (next.error != null && next.error != prev?.error) {
        scaffoldMessengerKey.currentState?.showSnackBar(
          _snackBar(
            message: next.error!,
            icon: Icons.error_outline_rounded,
            color: Colors.red.shade700,
          ),
        );
        ref.read(offlineSmsNotifierProvider.notifier).resetError();
      }
    });

    return child;
  }

  SnackBar _snackBar({
    required String message,
    required IconData icon,
    required Color color,
  }) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      duration: const Duration(seconds: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Row(
        children: [
          Icon(icon, color: Colors.white, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}