import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  late final StreamController<bool> _controller;
  Stream<bool> get connectivityStream => _controller.stream;

  ConnectivityService() {
    _controller = StreamController<bool>.broadcast();
    _connectivity.onConnectivityChanged.listen((_) => _checkInternet());
    _checkInternet();
  }

  Future<void> _checkInternet() async {
    bool connected = false;
    try {
      final Response<dynamic> result = await _dio.get('https://google.com');
      if (result.statusCode == 200) connected = true;
    } on DioException catch (_) {
      connected = false;
    }
    _controller.add(connected);
  }

  Future<bool> get isConnected async {
    try {
      final Response<dynamic> result = await _dio.get('https://google.com');
      return result.statusCode == 200;
    } on DioException catch (_) {
      return false;
    }
  }

  void dispose() {
    _controller.close();
    _dio.close();
  }
}
