import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/result/app_failure.dart';
import '../../../../core/result/result.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../presentation/providers/profile_providers.dart';
import '../models/profile_model.dart';
import '../sources/profile_remote_source.dart';

part 'profile_repository_impl.g.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl(this._source);
  final ProfileRemoteSource _source;

  @override
  // profile_repository_impl.dart
  Future<Result<Profile>> getProfile() async {
    try {
      final ProfileModel model = await _source.getProfile();
      // ignore: always_specify_types
      return Success(
        Profile(name: model.name, phone: model.phone, address: model.address),
      );
    } catch (e) {
      String errorMessage = _mapError(e.toString());
      return Failure(AppFailure(message: errorMessage));
    }
  }

  String _mapError(String rawError) {
    if (rawError.contains('network') || rawError.contains('SocketException')) {
      return 'Network error. Please check your internet connection.';
    }
    if (rawError.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (rawError.contains('unauthorized') || rawError.contains('401')) {
      return 'Session expired. Please login again.';
    }
    if (rawError.contains('not-found') || rawError.contains('404')) {
      return 'Profile not found. Please contact support.';
    }
    if (rawError.contains('permission-denied') || rawError.contains('403')) {
      return 'Permission denied. Please contact support.';
    }
    // Return original error if no specific mapping found
    if (rawError.startsWith('Exception: ')) {
      return rawError.substring(11);
    }
    return rawError;
  }
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final source = ref.watch(profileRemoteSourceProvider);
  return ProfileRepositoryImpl(source);
}
