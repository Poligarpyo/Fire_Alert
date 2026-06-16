import 'dart:math';

import '../../../../core/result/app_failure.dart';
import '../../../../core/result/result.dart';
import '../entities/report_incident.dart';
import '../repositories/report_incident_repository.dart';

class SendReportIncidentUseCase {
  final ReportIncidentRepository repository;

  SendReportIncidentUseCase(this.repository);

  static const int _maxReportsPerRadius = 10;
  static const double _radiusMeters = 300;
  static const int _withinMinutes = 60;

  Future<Result<void>> call(ReportIncident report) async {
    try {
      // ✅ Check radius + time limit before sending
      final count = await repository.countNearbyRecentReports(
        latitude: report.latitude,
        longitude: report.longitude,
        radiusMeters: _radiusMeters,
        withinMinutes: _withinMinutes,
      );

      if (count >= _maxReportsPerRadius) {
        return Result.failure(
          const AppFailure(
            message:
                'This area already has 10 reports within the last hour.\n'
                'Your report is not valid because it has the same coordinates.',
          ),
        );
      }

      return repository.sendReport(report);
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      return Result.failure(AppFailure(message: errorMessage));
    }
  }

  String _mapError(String rawError) {
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('permission-denied') || rawError.contains('403')) {
      return 'Permission denied. Please contact support.';
    }
    if (rawError.contains('unauthorized') || rawError.contains('401')) {
      return 'Session expired. Please login again.';
    }
    if (rawError.contains('database') || rawError.contains('storage')) {
      return 'Failed to save report. Please try again.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }
}
