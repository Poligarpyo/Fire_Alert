import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/result/result.dart';
import '../../domain/usecases/get_history_reports_usecase.dart';
import 'history_report_state.dart';

class HistoryReportNotifier extends StateNotifier<HistoryReportState> {
  HistoryReportNotifier(this._usecase)
    : super(const HistoryReportState.initial());
  final GetHistoryReportsUsecase _usecase;
  // ignore: always_specify_types, strict_raw_type
  StreamSubscription? _subscription;

  void watchReports() {
    state = const HistoryReportState.loading();
    _subscription?.cancel();

    _subscription = _usecase.watch().listen(
      (reports) => state = HistoryReportState.loaded(reports: reports),
      onError: (e) {
        String errorMessage = _mapError(e.toString());
        state = HistoryReportState.error(message: errorMessage);
      },
    );
  }

  String _mapError(String rawError) {
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('unauthorized') || rawError.contains('401')) {
      return 'Session expired. Please login again.';
    }
    if (rawError.contains('permission-denied') || rawError.contains('403')) {
      return 'Permission denied. Please contact support.';
    }
    if (rawError.contains('database') || rawError.contains('storage')) {
      return 'Failed to load reports. Please try again.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
