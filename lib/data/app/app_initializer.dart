import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/storage/auth_local_datasource_provider.dart';
import '../../features/authentication/presentation/controllers/auth/auth_controller.dart';
import '../repository/network_repository.dart';

part 'app_initializer.g.dart';

@riverpod
Future<void> appInitializer(Ref ref) async {
  final authLocal = ref.read(authLocalDataSourceProvider);
  final token = authLocal.getToken();
  final login = authLocal.getPhone();
  if (token == null || login == null) return;

  try {
    await ref
        .read(networkRepositoryProvider)
        .post(
          '/ClientCabinetBasic/GetAccountInformation',
          data: {'login': login, 'token': token},
        );

    if (ref.mounted) {
      ref.read(networkRepositoryProvider.notifier).setToken(token);
    }
  } catch (_) {
    // Check if the provider is still mounted before using ref
    if (ref.mounted) {
      await ref
          .read(authControllerProvider.notifier)
          .logout(message: 'Session expired. You have been logged out.');
    }
  }
}
