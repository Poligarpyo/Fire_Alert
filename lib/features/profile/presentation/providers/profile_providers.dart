import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/legacy.dart' show StateNotifierProvider;

import '../../../../core/storage/auth_local_datasource_provider.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../data/sources/profile_remote_source.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/usecase/get_profile_usecase.dart';
import '../controllers/profile_notifier.dart';
import '../controllers/profile_state.dart';

final dioProvider = Provider<Dio>((ref) => Dio());

final profileRemoteSourceProvider = Provider<ProfileRemoteSource>((ref) {
  final authLocalDataSource = ref.watch(authLocalDataSourceProvider);
  return ProfileRemoteSource(authLocalDataSource: authLocalDataSource);
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteSource = ref.watch(profileRemoteSourceProvider);
  return ProfileRepositoryImpl(remoteSource);
});

final getProfileUsecaseProvider = Provider<GetProfileUsecase>((ref) {
  final repository = ref.watch(profileRepositoryProvider); // ✅ watch not read
  return GetProfileUsecase(repository);
});

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
      final usecase = ref.watch(getProfileUsecaseProvider); // ✅ watch not read
      return ProfileNotifier(usecase);
    });

// ✅ Now fully reactive — auto re-fetches when phone changes
final currentProfileProvider = FutureProvider<Profile>((ref) async {
  final phoneAsync = ref.watch(loggedInPhoneProvider);

  final phone = phoneAsync.maybeWhen(data: (p) => p, orElse: () => null);

  if (phone == null || phone.isEmpty) {
    throw Exception('No logged-in user.');
  }

  final result = await ref.watch(getProfileUsecaseProvider)();
  return result.when(
    success: (profile) => profile,
    failure: (error) => throw Exception(error.message),
  );
});
