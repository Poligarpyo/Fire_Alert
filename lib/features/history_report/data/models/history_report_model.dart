import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_report_model.freezed.dart';
part 'history_report_model.g.dart';

@freezed
abstract class HistoryReportModel with _$HistoryReportModel {
  const factory HistoryReportModel({
    required String id,
    required String type,
    required String severity,
    required String location,
    required String date,
    required String status,
    @Default('') String additionalInfo,
    String? imageUrl,
    String? rescuer,
  }) = _HistoryReportModel;

  factory HistoryReportModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryReportModelFromJson(json);
}

@freezed
abstract class HistoryReportListResponse with _$HistoryReportListResponse {
  const factory HistoryReportListResponse({
    required List<HistoryReportModel> data,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(0) int totalCount,
  }) = _HistoryReportListResponse;

  factory HistoryReportListResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryReportListResponseFromJson(json);
}