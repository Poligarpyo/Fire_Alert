import 'dart:async';
import 'dart:io';

class IpAddressService {
  Future<String?> getLocalIpAddress() async {
    for (int i = 0; i < 5; i++) {
      try {
        final interfaces = await NetworkInterface.list();

        for (final interface in interfaces) {
          for (final addr in interface.addresses) {
            if (!addr.isLoopback && addr.type == InternetAddressType.IPv4) {
              return addr.address;
            }
          }
        }

        // wait before retry
        await Future.delayed(const Duration(seconds: 1));
      } catch (_) {}
    }

    return null;
  }
}
