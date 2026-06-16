import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/login/login_request.dart';
import '../../domain/entities/login/login_response.dart';
import '../../domain/entities/login/reset_password_request.dart';
import '../../domain/entities/register/register_request.dart';
import '../../domain/entities/register/register_response.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../../../../../core/result/app_failure.dart';
import '../../../../../core/result/result.dart';
import '../sources/auth_remote_source.dart';

part 'authentication_repository_impl.g.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this._remoteSource);
  final AuthRemoteSource _remoteSource;

  @override
  Future<Result<LoginResponse>> login(LoginCredentials credentials) async {
    try {
      final response = await _remoteSource.login(credentials);
      return Result.success(response);
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      return Result.failure(AppFailure(message: errorMessage));
    }
  }

  @override
  Future<Result<RegisterResponse>> register(RegisterRequest request) async {
    try {
      final response = await _remoteSource.register(request);

      if (!response.success) {
        return Result.failure(AppFailure(message: response.message));
      }

      return Result.success(response);
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
    if (rawError.contains('credentials') || rawError.contains('password')) {
      return 'Invalid credentials. Please try again.';
    }
    if (rawError.contains('already-exists') ||
        rawError.contains('already registered')) {
      return 'This phone number is already registered.';
    }
    if (rawError.contains('unauthorized') || rawError.contains('401')) {
      return 'Authentication failed. Please try again.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }

  @override
  Future<Result<void>> resetPassword(ResetPasswordRequest request) async {
    try {
      await _remoteSource.resetPassword(request);
      return Result.success(null);
    } catch (e) {
      return Result.failure(AppFailure(message: e.toString()));
    }
  }
}

@riverpod
AuthenticationRepository authenticationRepository(Ref ref) {
  final remoteSource = ref.watch(authRemoteSourceProvider);
  return AuthenticationRepositoryImpl(remoteSource);
}
