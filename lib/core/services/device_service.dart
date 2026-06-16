import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceIdService {
  static const _deviceIdKey = 'device_unique_id';

  Future<String> getDeviceId() async {
    final prefs = await SharedPreferences.getInstance();

    // already exists
    final existingId = prefs.getString(_deviceIdKey);

    if (existingId != null && existingId.isNotEmpty) {
      return existingId;
    }

    // first install/open
    final newId = const Uuid().v4();

    await prefs.setString(_deviceIdKey, newId);

    return newId;
  }
}