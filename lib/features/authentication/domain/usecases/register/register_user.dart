import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../core/result/result.dart';
import '../../../data/repositories/authentication_repository_impl.dart';
import '../../entities/register/register_request.dart';
import '../../entities/register/register_response.dart';
import '../../repositories/authentication_repository.dart';

part 'register_user.g.dart';

@riverpod
RegisterUserUseCase registerUserUseCase(Ref ref) {
  return RegisterUserUseCase(ref.watch(authenticationRepositoryProvider));
}

class RegisterUserUseCase {
  final AuthenticationRepository _repository;

  RegisterUserUseCase(this._repository);

  // ✅ Return Result<RegisterResponse> instead of raw RegisterResponse
  Future<Result<RegisterResponse>> call(RegisterRequest request) async {
    return _repository.register(request);
  }
}