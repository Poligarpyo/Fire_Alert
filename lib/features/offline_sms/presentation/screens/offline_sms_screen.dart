import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/theme/app_theme.dart';
import '../controllers/offline_sms/notifier.dart';
import '../controllers/offline_sms/state.dart';
import '../widgets/content.dart';
import '../widgets/header_sms_offline.dart';
import '../widgets/sync_status_banner.dart';

class OfflineSmsScreen extends ConsumerWidget {
  const OfflineSmsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    ref.listen<OfflineSmsState>(offlineSmsNotifierProvider, (prev, next) {
      if (!context.mounted) return;

      // Show error snackbar before popping so ScaffoldMessenger context is valid.
      if (next.error != null && next.error != prev?.error) {
        ref.read(offlineSmsNotifierProvider.notifier).resetError();
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBar(
            message: next.error!,
            icon: Icons.error_outline_rounded,
            color: Colors.red.shade700,
          ),
        );
      }

      if (next.shouldCloseDialog && !(prev?.shouldCloseDialog ?? false)) {
        ref.read(offlineSmsNotifierProvider.notifier).resetCloseDialog();
        Navigator.of(context).maybePop();
        return;
      }

      if (next.success && !(prev?.success ?? false)) {
        ref.read(offlineSmsNotifierProvider.notifier).resetStatus();
        Navigator.of(context).maybePop();
        ScaffoldMessenger.of(context).showSnackBar(
          _snackBar(
            message: 'Emergency SMS sent successfully.',
            icon: Icons.check_circle_outline_rounded,
            color: Colors.green.shade700,
          ),
        );
      }
    });

    return Dialog(
      backgroundColor: context.backgroundColor,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: size.height * 0.85,
          maxWidth: size.width > 600 ? 500 : size.width,
        ),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HeaderSmsOffline(),
            SyncStatusBanner(),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Content(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SnackBar _snackBar({
    required String message,
    required IconData icon,
    required Color color,
  }) {
    return SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
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