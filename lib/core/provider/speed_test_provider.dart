import 'dart:ui';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../data/enums/connection_quality.dart';
import '../services/speed_test_service.dart';

class SpeedTestConfig {
  const SpeedTestConfig._();
  static const Duration pollingInterval = Duration(minutes: 1);
}

final Provider<SpeedTestService> speedTestServiceProvider =
    Provider<SpeedTestService>((_) => SpeedTestService());

final StateProvider<bool> isOfflineDialogShowingProvider = StateProvider<bool>(
  (_) => false,
);

final speedTestRefreshProvider = StateProvider<int>((_) => 0);

/// Emits ping in milliseconds
final speedTestProvider = StreamProvider.autoDispose<double>((ref) async* {
  ref.watch(speedTestRefreshProvider);
  final service = ref.read(speedTestServiceProvider);

  try {
    yield await service.measureSpeedMbps();
  } catch (_) {
    yield 0.0;
  }

  while (true) {
    await Future.delayed(SpeedTestConfig.pollingInterval);
    try {
      yield await service.measureSpeedMbps();
    } catch (_) {
      yield 0.0;
    }
  }
});

final connectionQualityProvider = Provider.autoDispose<ConnectionQuality>((
  ref,
) {
  return ref
      .watch(speedTestProvider)
      .maybeWhen(
        data: (mbps) => ref.read(speedTestServiceProvider).classify(mbps),
        orElse: () => ConnectionQuality.offline,
      );
});

final canSendReportProvider = Provider.autoDispose<bool>((ref) {
  final quality = ref.watch(connectionQualityProvider);
  return quality != ConnectionQuality.offline;
});

final speedBadgePositionProvider = StateProvider<Offset>(
  (_) => const Offset(double.infinity, 100),
);
