import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/device_service.dart';

final deviceIdServiceProvider = Provider<DeviceIdService>((ref) {
  return DeviceIdService();
});

final deviceIdProvider = FutureProvider<String>((ref) async {
  final service = ref.read(deviceIdServiceProvider);

  return service.getDeviceId();
});
