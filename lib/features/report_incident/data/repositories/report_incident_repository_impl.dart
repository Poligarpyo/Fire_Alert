import '../../../../core/result/app_failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/report_incident.dart';
import '../../domain/repositories/report_incident_repository.dart';
import '../models/report_incident_model.dart';
import '../sources/report_incident_firebase_source.dart';

class ReportIncidentRepositoryImpl implements ReportIncidentRepository {
  ReportIncidentRepositoryImpl({required this.firebaseSource});
  final ReportIncidentFirebaseSource firebaseSource;

  @override
  Future<Result<void>> sendReport(ReportIncident report) async {
    try {
      final model = ReportIncidentModel.fromEntity(report);
      await firebaseSource.sendReport(model);
      return const Success(null);
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      return Failure(AppFailure(message: errorMessage));
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

  @override
  Future<int> countNearbyRecentReports({
    required double latitude,
    required double longitude,
    double radiusMeters = 300,
    int withinMinutes = 60,
  }) {
    return firebaseSource.countNearbyRecentReports(
      latitude: latitude,
      longitude: longitude,
      radiusMeters: radiusMeters,
      withinMinutes: withinMinutes,
    );
  }
}
