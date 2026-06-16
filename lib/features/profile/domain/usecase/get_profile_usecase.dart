import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/result/result.dart';
import '../../../../core/result/app_failure.dart';
import '../entities/profile.dart';
import '../repositories/profile_repository.dart';
import '../../data/repositories/profile_repository_impl.dart';

part 'get_profile_usecase.g.dart';

class GetProfileUsecase {
  final ProfileRepository _repository;

  GetProfileUsecase(this._repository);

  Future<Result<Profile>> call() => _repository.getProfile();
}

@riverpod
GetProfileUsecase getProfileUsecase(Ref ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return GetProfileUsecase(repo);
}
