import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/storage/auth_local_datasource.dart';
import '../models/offline_sms_model.dart';

class OfflineSmsRemoteSource {
  const OfflineSmsRemoteSource({
    required this.firestore,
    required this.auth,
    required this.authLocalDataSource,
  });

  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  final AuthLocalDataSource authLocalDataSource;

  Future<bool> sendReport(OfflineSmsModel sms) async {
    try {
      final login = authLocalDataSource.getPhone();

      final cleanedMessage = sms.message
          .replaceAll(RegExp(r'\nLocation:.*'), '')
          .trim();

      // Match mo sa Firestore structure mo:
      // offline_sms → emergency_911 → fields
      await firestore
          .collection('offline_sms')
          .doc(sms.id) // ← 'emergency_911' or actual ID
          .set({
            'id': sms.id,
            'message': cleanedMessage,
            'latitude': sms.latitude,
            'longitude': sms.longitude,
            'phone_number': login?.isNotEmpty ?? false
                ? login!
                : sms.phoneNumber,
            'createdAt': DateTime.now().toIso8601String(),
            'deviceId': sms.deviceId,
          });

      return true;
    } on FirebaseException catch (e) {
      String errorMessage = _mapFirebaseError(e);
      throw Exception(errorMessage);
    }
  }

  Future<OfflineSmsModel?> getLatestOfflineSms() async {
    try {
      final login = authLocalDataSource.getPhone();
      print("login $login");
      if (login == null || login.isEmpty) return null;

      final snapshot = await firestore
          .collection('offline_sms')
          .where('phone_number', isEqualTo: login)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return OfflineSmsModel.fromJson(snapshot.docs.first.data());
    } on FirebaseException catch (e) {
      String errorMessage = _mapFirebaseError(e);
      throw Exception(errorMessage);
    }
  }

  // In offline_sms_remote_source.dart — rename/add this method
  Future<OfflineSmsModel?> checkNearDeviceId(String deviceId) async {
    try {
      print("Checking deviceId: $deviceId");
      if (deviceId.isEmpty) return null;

      final snapshot = await firestore
          .collection('offline_sms')
          .where('deviceId', isEqualTo: deviceId)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) return null;

      return OfflineSmsModel.fromJson(snapshot.docs.first.data());
    } on FirebaseException catch (e) {
      String errorMessage = _mapFirebaseError(e);
      throw Exception(errorMessage);
    }
  }

  String _mapFirebaseError(FirebaseException e) {
    switch (e.code) {
      case 'unauthorized':
      case 'permission-denied':
        return 'Permission denied. Please contact support.';
      case 'network-request-failed':
      case 'unavailable':
        return 'Network error. Please check your internet connection.';
      case 'timeout':
        return 'Request timed out. Please try again.';
      case 'quota-exceeded':
        return 'Storage quota exceeded. Please try again later.';
      case 'canceled':
        return 'Operation was cancelled.';
      default:
        return e.message ?? 'Failed to save report.';
    }
  }
}
