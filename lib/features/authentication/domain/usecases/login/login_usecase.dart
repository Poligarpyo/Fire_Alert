import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
 
import '../../../../../core/result/result.dart';
import '../../../data/repositories/authentication_repository_impl.dart';
import '../../entities/login/login_request.dart';
import '../../entities/login/login_response.dart';
import '../../repositories/authentication_repository.dart';
 
part 'login_usecase.g.dart';

/// Single job: execute the login flow.
/// The controller calls this — never the repository directly.
class LoginUseCase {
  LoginUseCase(this._repository);
  final AuthenticationRepository _repository;

  Future<Result<LoginResponse>> execute(LoginCredentials credentials) =>
      _repository.login(credentials);
}

@riverpod
LoginUseCase loginUseCase(Ref ref) {
  final repository = ref.watch(authenticationRepositoryProvider);
  return LoginUseCase(repository);
}