import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../data/enums/auth_status.dart';
import '../../../../../shared/common/app_snackbar.dart';
import '../../../../../shared/common/navigation_keys.dart';
import '../../../../../core/storage/auth_local_datasource_provider.dart';
import '../../../../../data/repository/network_repository.dart';
// Add this import 👇
import '../../../../../features/profile/presentation/providers/profile_providers.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  AuthStatus build() {
    final token = ref.read(authLocalDataSourceProvider).getToken();
    return token != null && token.isNotEmpty
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  Future<void> logout({String? message}) async {
    await ref.read(authLocalDataSourceProvider).clearToken();
    await ref.read(authLocalDataSourceProvider).clearLogin();
    ref.read(networkRepositoryProvider.notifier).clearToken();

    // Invalidate profile so next login gets a fresh fetch 👇
    // ref.invalidate(currentProfileProvider);

    state = AuthStatus.unauthenticated;

    if (message != null) {
      final context = rootNavigatorKey.currentContext;
      if (context != null) {
        AppSnackbar.showMessage(
          context,
          message,
          duration: const Duration(seconds: 2),
        );
      }
    }
    print(
      'X removeToken — ${ref.read(authLocalDataSourceProvider).getToken()}',
    );
    print(
      'X removePhone — ${ref.read(authLocalDataSourceProvider).getPhone()}',
    );
    print('✅ setToken called');
  }

  Future<void> loginSuccess({
    required String token,
    required String phone,
  }) async {
    // Save credentials FIRST before changing state 👇
    await ref.read(authLocalDataSourceProvider).saveToken(token);
    await ref.read(authLocalDataSourceProvider).savePhone(phone);
    ref.read(networkRepositoryProvider.notifier).setToken(token);

    // Invalidate so currentProfileProvider re-fetches with new phone 👇
    // ref.invalidate(currentProfileProvider);

    // Change state LAST so UI rebuilds after everything is ready 👇
    state = AuthStatus.authenticated;

    print('✅ saveToken — ${ref.read(authLocalDataSourceProvider).getToken()}');
    print('✅ savePhone — ${ref.read(authLocalDataSourceProvider).getPhone()}');
    print('✅ setToken called');
  }
}
