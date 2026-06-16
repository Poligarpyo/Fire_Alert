import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/history_report.dart';

part 'history_report_state.freezed.dart';

@freezed
class HistoryReportState with _$HistoryReportState {
  const factory HistoryReportState.initial() = _Initial;
  const factory HistoryReportState.loading() = _Loading;
  const factory HistoryReportState.loaded({
    required List<HistoryReport> reports,
  }) = _Loaded;
  const factory HistoryReportState.error({required String message}) = _Error;
}