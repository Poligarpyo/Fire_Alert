import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ip_address_service.dart';

final ipAddressServiceProvider = Provider<IpAddressService>((ref) {
  return IpAddressService();
});

final localIpProvider = FutureProvider<String?>((ref) async {
  final service = ref.watch(ipAddressServiceProvider);
  return service.getLocalIpAddress();
});