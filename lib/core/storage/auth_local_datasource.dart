import 'package:hive_ce/hive.dart';

const String authBoxName = 'authBox';

const String tokenKey = 'token';
const String loginKey = 'login';
const String splashShownKey = 'splashShown';

/// Biometric Keys
const String biometricEnabledKey = 'biometricEnabled';
const String biometricPhoneKey = 'biometricPhone';

/// IMPORTANT:
/// Store token instead of password
const String biometricTokenKey = 'biometricToken';

class AuthLocalDataSource {
  final Box box;

  AuthLocalDataSource(this.box);

  // ─────────────────────────────────────────────
  // PHONE
  // ─────────────────────────────────────────────

  Future<void> savePhone(String phone) async {
    await box.put(loginKey, phone);
  }

  String? getPhone() {
    return box.get(loginKey) as String?;
  }

  Future<void> clearLogin() async {
    await box.delete(loginKey);
  }

  // ─────────────────────────────────────────────
  // TOKEN
  // ─────────────────────────────────────────────

  Future<void> saveToken(String token) async {
    await box.put(tokenKey, token);
  }

  String? getToken() {
    return box.get(tokenKey) as String?;
  }

  Future<void> clearToken() async {
    await box.delete(tokenKey);
  }

  // ─────────────────────────────────────────────
  // SPLASH
  // ─────────────────────────────────────────────

  Future<void> setSplashShown() async {
    await box.put(splashShownKey, true);
  }

  bool isSplashShown() {
    return (box.get(splashShownKey) as bool?) ?? false;
  }

  Future<void> clearSplashShown() async {
    await box.delete(splashShownKey);
  }

  // ─────────────────────────────────────────────
  // BIOMETRIC
  // ─────────────────────────────────────────────

  Future<void> setBiometricEnabled(
    bool enabled,
  ) async {
    await box.put(
      biometricEnabledKey,
      enabled,
    );
  }

  bool isBiometricEnabled() {
    return (box.get(
              biometricEnabledKey,
            ) as bool?) ??
        false;
  }

  /// Save biometric login data
  ///
  /// IMPORTANT:
  /// Save TOKEN instead of PASSWORD
  Future<void> saveBiometricData({
    required String phone,
    required String token,
  }) async {
    await box.put(
      biometricPhoneKey,
      phone,
    );

    await box.put(
      biometricTokenKey,
      token,
    );
  }

  String? getBiometricPhone() {
    return box.get(
      biometricPhoneKey,
    ) as String?;
  }

  String? getBiometricToken() {
    return box.get(
      biometricTokenKey,
    ) as String?;
  }

  Future<void> clearBiometricData() async {
    await box.delete(
      biometricEnabledKey,
    );

    await box.delete(
      biometricPhoneKey,
    );

    await box.delete(
      biometricTokenKey,
    );
  }
}