import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/login/login_request.dart';
import '../../domain/entities/login/login_response.dart';
import '../../domain/entities/login/reset_password_request.dart';
import '../../domain/entities/register/register_request.dart';
import '../../domain/entities/register/register_response.dart';

part 'auth_remote_source.g.dart';

abstract class AuthRemoteSource {
  Future<LoginResponse> login(LoginCredentials credentials);
  Future<RegisterResponse> register(RegisterRequest request);
  Future<void> resetPassword(ResetPasswordRequest request);
}

class AuthRemoteSourceImpl implements AuthRemoteSource {
  AuthRemoteSourceImpl();

  String _generateSalt() {
    final rand = Random.secure();
    final saltBytes = List<int>.generate(16, (_) => rand.nextInt(256));
    return base64Encode(saltBytes);
  }

  String _hashPassword(String password, String salt) {
    final bytes = utf8.encode('$salt:$password');
    return sha256.convert(bytes).toString();
  }

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

  @override
  Future<LoginResponse> login(LoginCredentials credentials) async {
    try {
      final normalizedPhone = _normalizePhone(credentials.phone);
      final doc = await FirebaseFirestore.instance
          .collection('app_users')
          .doc(normalizedPhone)
          .get();

      if (!doc.exists) {
        throw Exception('Invalid credentials. Please try again!');
      }

      final data = doc.data();
      final storedPassword = (data?['password'] ?? '').toString();
      print(
        'Login attempt for $normalizedPhone with stored password: $storedPassword',
      ); // Debug log
      final salt = (data?['salt'] ?? '').toString();
      print('Using salt: $salt'); // Debug log
      if (storedPassword != _hashPassword(credentials.password, salt)) {
        // <-- hash before comparing
        throw Exception('Invalid credentials. Please try again!');
      }

      return LoginResponse(token: 'app_users:$normalizedPhone', result: true);
    } on FirebaseException catch (e) {
      String errorMessage = _mapFirebaseError(e);
      throw Exception(errorMessage);
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      throw Exception(errorMessage);
    }
  }

  @override
  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final normalizedPhone = request.phone.trim();
      final appUsers = FirebaseFirestore.instance.collection('app_users');
      final existingUser = await appUsers.doc(normalizedPhone).get();

      if (existingUser.exists) {
        return const RegisterResponse(
          message: 'This phone number is already registered.',
          success: false,
        );
      }
      final salt = _generateSalt(); // generate once
      await appUsers.doc(normalizedPhone).set({
        'name': request.name.trim(),
        'phone': normalizedPhone,
        'address': request.address.trim(),
        'password': _hashPassword(request.password, salt), // <-- hash here
        'salt': salt,
        'created_at': FieldValue.serverTimestamp(),
      });

      return RegisterResponse(
        message: 'Registration successful.',
        success: true,
        userId: normalizedPhone,
      );
    } on FirebaseException catch (e) {
      return RegisterResponse(
        message: 'Registration failed: ${e.message ?? 'Please try again.'}',
        success: false,
      );
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      return RegisterResponse(message: errorMessage, success: false);
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
      case 'already-exists':
        return 'This phone number is already registered.';
      default:
        return e.message ?? 'Authentication failed. Please try again.';
    }
  }

  String _mapError(String rawError) {
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('credentials') || rawError.contains('password')) {
      return 'Invalid credentials. Please try again.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }

  @override
  Future<void> resetPassword(ResetPasswordRequest request) async {
    try {
      final normalizedPhone = _normalizePhone(request.phone);
      final appUsers = FirebaseFirestore.instance.collection('app_users');
      final userDoc = await appUsers.doc(normalizedPhone).get();

      if (!userDoc.exists) {
        throw Exception('No account found for this phone number.');
      }

      final salt = _generateSalt();
      await appUsers.doc(normalizedPhone).update({
        'password': _hashPassword(request.password, salt),
        'salt': salt,
        'updated_at': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      throw Exception('Password reset failed: ${e.message ?? 'Please try again.'}');
    }
  }
}

@riverpod
AuthRemoteSource authRemoteSource(Ref ref) {
  return AuthRemoteSourceImpl();
}
