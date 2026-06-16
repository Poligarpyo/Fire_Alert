import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod/riverpod.dart';

import '../../../../../core/result/result.dart';
import '../../data/repositories/authentication_repository_impl.dart';
import '../entities/login/reset_password_request.dart';
import '../repositories/authentication_repository.dart';

part 'reset_password_usecase.g.dart';

class ResetPasswordUseCase {
  ResetPasswordUseCase(this._repository);

  final AuthenticationRepository _repository;

  Future<Result<void>> execute(ResetPasswordRequest request) =>
      _repository.resetPassword(request);
}

@riverpod
ResetPasswordUseCase resetPasswordUseCase(Ref ref) {
  final repository = ref.watch(authenticationRepositoryProvider);
  return ResetPasswordUseCase(repository);
}
