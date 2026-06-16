import '../entities/offline_sms.dart';

abstract class OfflineSmsRepository {
  Future<void> sendEmergencySMS(String message);
  Future<void> saveOffline(OfflineSms sms);
  Future<void> syncPendingReports();
  Future<int> getPendingCount(); //
  Future<OfflineSms?> getLatestOfflineSms();
}
