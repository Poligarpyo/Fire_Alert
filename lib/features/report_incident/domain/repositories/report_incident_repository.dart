import '../../../../core/result/result.dart';
import '../entities/report_incident.dart';

abstract class ReportIncidentRepository {
  Future<Result<void>> sendReport(ReportIncident report);
  Future<int> countNearbyRecentReports({
    // ✅ add
    required double latitude,
    required double longitude,
    double radiusMeters = 300,
    int withinMinutes = 60,
  });
}
