import 'package:permission_handler/permission_handler.dart';

enum SmsPermissionResult { granted, denied, permanentlyDenied }

Future<SmsPermissionResult> requestSmsPermission() async {
  final status = await Permission.sms.status;

  // Already granted — nothing to do
  if (status.isGranted) return SmsPermissionResult.granted;

  // Permanently denied — caller decides whether to open settings
  if (status.isPermanentlyDenied) {
    return SmsPermissionResult.permanentlyDenied;
  }

  // Request it
  final result = await Permission.sms.request();

  if (result.isGranted) return SmsPermissionResult.granted;
  if (result.isPermanentlyDenied) return SmsPermissionResult.permanentlyDenied;

  return SmsPermissionResult.denied;
}

Future<bool> requestLocationPermission() async {
  final status = await Permission.location.status;

  if (status.isGranted) return true;

  if (status.isPermanentlyDenied) {
    await openAppSettings(); // Location is less restricted, settings redirect is fine
    return false;
  }

  final result = await Permission.location.request();
  return result.isGranted;
}