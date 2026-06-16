import '../../../../core/result/result.dart';
import '../../../../core/result/app_failure.dart';
import '../entities/profile.dart';

abstract interface class ProfileRepository {
  Future<Result<Profile>> getProfile();
}
