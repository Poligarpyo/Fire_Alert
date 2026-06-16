import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/provider/connectivity_provider.dart';
import '../../features/offline_sms/presentation/widgets/offline_sms_listener.dart';
import '../helper/offline_screen.dart';
import 'navigation_keys.dart';

class ConnectivityListener extends ConsumerStatefulWidget {
  const ConnectivityListener({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<ConnectivityListener> createState() =>
      _ConnectivityListenerState();
}

class _ConnectivityListenerState extends ConsumerState<ConnectivityListener> {
  late StreamSubscription<bool> _subscription;
  bool _dialogShowing = false;

  @override
  void initState() {
    super.initState();
    final service = ref.read(connectivityProvider);

    _subscription = service.connectivityStream.listen((connected) {
      if (connected) {
        _dialogShowing = false;

        // TANGGALIN na ang "Back online!" snackbar dito
        // Ang sync snackbar na lang ang mag-aappear
        // dahil mas meaningful yun kaysa generic "Back online!"
      } else {
        if (!_dialogShowing) {
          _dialogShowing = true;

          WidgetsBinding.instance.addPostFrameCallback((_) {
            final context = rootNavigatorKey.currentContext;

            if (context != null) {
              final routeName =
                  rootNavigatorKey.currentState?.overlay?.mounted == true
                  ? ModalRoute.of(
                      rootNavigatorKey.currentState!.overlay!.context,
                    )?.settings.name
                  : null;

              if (routeName != '/splash') {
                showOfflineSMSDialog(context);
              } else {
                _dialogShowing = false;
              }
            } else {
              _dialogShowing = false;
            }
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      // WRAP ng OfflineSmsListener para aktibo siya sa buong app
      OfflineSmsListener(child: widget.child);
}
