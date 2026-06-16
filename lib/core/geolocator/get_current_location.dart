import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {
  // ── Step 1: GPS enabled? ──────────────────────────────────────────────────
  if (!await Geolocator.isLocationServiceEnabled()) {
    // ✅ Prompt user to turn on GPS — shows native dialog
    await Geolocator.openLocationSettings();

    // Re-check after returning from settings
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw 'GPS is still disabled. Please turn on Location Services.';
    }
  }

  // ── Step 2: Check permission ──────────────────────────────────────────────
  LocationPermission permission = await Geolocator.checkPermission();

  // ── Step 3: Permanently denied → open app settings ───────────────────────
  if (permission == LocationPermission.deniedForever) {
    // ✅ Takes user directly to app permission page
    await Geolocator.openAppSettings();

    // Re-check after they return
    permission = await Geolocator.checkPermission();

    if (!_isGranted(permission)) {
      throw 'Location permission is required to submit a report.';
    }
  }

  // ── Step 4: Not yet asked → request it ───────────────────────────────────
  if (permission == LocationPermission.denied) {
    // ✅ This triggers the system popup dialog
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      throw 'Location permission was denied.';
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      throw 'Please grant location permission in Settings and try again.';
    }
  }

  // ── Step 5: Get position ──────────────────────────────────────────────────
  return Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.high,
    timeLimit: const Duration(seconds: 10),
  );
}

bool _isGranted(LocationPermission p) =>
    p == LocationPermission.always ||
    p == LocationPermission.whileInUse;