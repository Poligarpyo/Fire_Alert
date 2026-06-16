import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/storage/auth_local_datasource.dart';
import '../models/profile_model.dart';

class ProfileRemoteSource {
  const ProfileRemoteSource({required AuthLocalDataSource authLocalDataSource})
    : _authLocalDataSource = authLocalDataSource;

  final AuthLocalDataSource _authLocalDataSource;

  String _normalizePhone(String rawPhone) {
    final digitsOnly = rawPhone.replaceAll(RegExp(r'[^0-9+]'), '');
    if (digitsOnly.startsWith('+63')) return digitsOnly;
    if (digitsOnly.startsWith('09') && digitsOnly.length == 11) {
      return '+63${digitsOnly.substring(1)}';
    }
    if (digitsOnly.startsWith('9') && digitsOnly.length == 10) {
      return '+63$digitsOnly';
    }
    return rawPhone.trim();
  }

  Future<ProfileModel> getProfile() async {
    try {
      final localLoginPhone = _authLocalDataSource.getPhone();
      final authPhone = FirebaseAuth.instance.currentUser?.phoneNumber;
      final phoneSource =
          (localLoginPhone != null && localLoginPhone.isNotEmpty)
          ? localLoginPhone
          : authPhone;

      if (phoneSource == null || phoneSource.isEmpty) {
        throw Exception('No logged-in user found.');
      }

      final normalizedPhone = _normalizePhone(phoneSource);
      final doc = await FirebaseFirestore.instance
          .collection('app_users')
          .doc(normalizedPhone)
          .get();

      if (!doc.exists) {
        throw Exception('User profile not found.');
      }

      final data = doc.data() ?? <String, dynamic>{};
      return ProfileModel(
        name: (data['name'] ?? '').toString(),
        phone: (data['phone'] ?? normalizedPhone).toString(),
        address: (data['address'] ?? '').toString(),
      );
    } on FirebaseException catch (e) {
      String errorMessage = _mapFirebaseError(e);
      throw Exception(errorMessage);
    } catch (e) {
      String errorMessage = _mapError(e.toString());
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
      case 'not-found':
        return 'User profile not found.';
      default:
        return e.message ?? 'Failed to load profile.';
    }
  }

  String _mapError(String rawError) {
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('user') && rawError.contains('found')) {
      return 'User profile not found.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }
}
