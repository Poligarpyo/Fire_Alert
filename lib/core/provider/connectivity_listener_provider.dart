import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/offline_sms/presentation/controllers/offline_sms/notifier.dart';
import 'connectivity_provider.dart';

final Provider<void> autoSyncProvider = Provider<void>((Ref ref) {
  ref.listen<AsyncValue<bool>>(connectivityStatusProvider, (
    AsyncValue<bool>? previous,
    AsyncValue<bool> next,
  ) async {
    final wasConnected = previous?.value ?? false;
    final isConnected = next.value ?? false;

    // Mag-sync lang kapag BAGONG nag-online (hindi paulit-ulit)
    if (!wasConnected && isConnected) {
      try {
        print("Internet restored — starting sync");
        await ref
            .read(offlineSmsNotifierProvider.notifier)
            .syncReports(); // ← PALITAN ito
        print("Sync complete");
      } catch (e) {
        print("Sync error: $e");
      }
    }
  });
});