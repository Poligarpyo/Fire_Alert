import '../../../../core/result/result.dart';
import '../../../../core/result/app_failure.dart';
import '../../domain/entities/history_report.dart';
import '../../domain/repositories/history_report_repository.dart';
import '../models/history_report_model.dart';
import '../sources/history_report_remote_source.dart';

class HistoryReportRepositoryImpl implements HistoryReportRepository {
  const HistoryReportRepositoryImpl(this._remoteSource);
  final HistoryReportRemoteSource _remoteSource;

  @override
  Stream<List<HistoryReport>> watchHistoryReports({
    String? type,
    String? severity,
  }) {
    return _remoteSource.watchHistoryReports().map(
      (response) => response.data.map(_mapToEntity).toList(),
    );
  }

  HistoryReport _mapToEntity(HistoryReportModel model) {
    return HistoryReport(
      id: model.id,
      type: model.type,
      severity: model.severity,
      location: model.location,
      date: model.date,
      status: model.status,
      additionalInfo: model.additionalInfo,
      imageUrl: model.imageUrl,
      rescuer: model.rescuer,
    );
  }
}
