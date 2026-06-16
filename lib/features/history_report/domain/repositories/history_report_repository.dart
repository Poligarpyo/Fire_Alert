import '../../../../core/result/result.dart';
import '../entities/history_report.dart';

// ignore: one_member_abstracts
abstract class HistoryReportRepository {
  Stream<List<HistoryReport>> watchHistoryReports();
}
