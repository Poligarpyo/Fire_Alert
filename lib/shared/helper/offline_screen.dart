import 'package:flutter/material.dart';
import '../../features/offline_sms/presentation/screens/offline_sms_screen.dart';

// Change void → Future<void>
Future<void> showOfflineSMSDialog(BuildContext context) {
  return showDialog(
    context: context,
    // barrierDismissible: true,
    builder: (BuildContext context) => const OfflineSmsScreen(),
  );
}
