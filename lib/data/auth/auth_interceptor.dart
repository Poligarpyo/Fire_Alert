import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import '../../features/authentication/presentation/controllers/auth/auth_controller.dart';
 
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this.ref);
  final Ref ref;

  bool _isLoggingOut = false;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 500 && !_isLoggingOut) {
      _isLoggingOut = true;
      await ref
          .read(authControllerProvider.notifier)
          .logout(message: 'Session expired. You have been logged out.');
    }

    return handler.next(err);
  }
}
