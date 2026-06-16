import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../../data/enums/connection_quality.dart';

class SpeedTestService {
  SpeedTestService({Dio? dio}) : _dio = dio ?? _buildDio();
  final Dio _dio;

  static Dio _buildDio() {
    return Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Connection': 'keep-alive',
          'Cache-Control': 'no-cache',
        },
      ),
    );
  }

  // Multiple reliable fallback URLs — different CDNs
  static const List<String> _testUrls = [
    'https://speed.cloudflare.com/__down?bytes=100000', // 100KB - Cloudflare
    'https://httpbin.org/bytes/100000',                 // 100KB - fallback
    'https://www.google.com/images/phd/px.gif',        // tiny - last resort
  ];

  Future<double> measureSpeedMbps() async {
    if (!await _isConnected()) return 0.0;

    for (final url in _testUrls) {
      final result = await _tryMeasure(url);
      if (result > 0.0) return result;
    }

    return 0.0;
  }

  Future<double> _tryMeasure(String url) async {
    try {
      // Take 3 samples, drop highest and lowest, return middle
      final samples = <double>[];

      for (int i = 0; i < 3; i++) {
        final stopwatch = Stopwatch()..start();
        final response = await _dio.get<List<int>>(
          url,
          options: Options(responseType: ResponseType.bytes),
        );
        stopwatch.stop();

        final bytes = response.data?.length ?? 0;
        if (bytes == 0) continue;

        final seconds = stopwatch.elapsedMilliseconds / 1000;
        final mbps = (bytes * 8) / (seconds * 1_000_000);
        samples.add(mbps);
      }

      if (samples.isEmpty) return 0.0;
      if (samples.length == 1) return samples.first;

      // Drop outliers, return median
      samples.sort();
      return double.parse(
        samples[samples.length ~/ 2].toStringAsFixed(2),
      );
    } catch (_) {
      return 0.0;
    }
  }

  ConnectionQuality classify(double mbps) {
    if (mbps >= 5.0) return ConnectionQuality.excellent;
    if (mbps >= 1.0) return ConnectionQuality.good;
    if (mbps >= 0.5) return ConnectionQuality.poor;
    return ConnectionQuality.offline;
  }

  Future<bool> _isConnected() async {
    final results = await Connectivity().checkConnectivity();
    return !results.contains(ConnectivityResult.none) && results.isNotEmpty;
  }
}