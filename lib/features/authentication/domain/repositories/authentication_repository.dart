import '../../../../core/result/result.dart';
import '../entities/login/login_request.dart';
import '../entities/login/login_response.dart';
import '../entities/login/reset_password_request.dart';
import '../entities/register/register_request.dart';
import '../entities/register/register_response.dart';

/// Abstract contract — domain layer owns this.
/// Presentation depends on this, NOT on the data implementation.
// authentication_repository.dart
abstract class AuthenticationRepository {
  Future<Result<LoginResponse>> login(LoginCredentials credentials);
  Future<Result<RegisterResponse>> register(RegisterRequest request);
  Future<Result<void>> resetPassword(ResetPasswordRequest request);
}