import '../../../../core/result/result.dart';
import '../entities/history_report.dart';
import '../repositories/history_report_repository.dart';

class GetHistoryReportsUsecase {
  const GetHistoryReportsUsecase(this._repository);
  final HistoryReportRepository _repository;

  Stream<List<HistoryReport>> watch() {
    return _repository.watchHistoryReports();
  }
}
