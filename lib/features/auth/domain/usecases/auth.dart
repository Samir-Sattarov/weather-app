import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login_request_params.dart';
import '../repositories/authentication_repository.dart';

class LogginedUser extends UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogginedUser(this._authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(NoParams params) =>
      _authenticationRepository.logginedUser();
}

class SignIn extends UseCase<bool, LoginRequestParams> {
  final AuthenticationRepository _authenticationRepository;

  SignIn(this._authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(LoginRequestParams params) async =>
      _authenticationRepository.signIn(params);
}

class SignUp extends UseCase<bool, LoginRequestParams> {
  final AuthenticationRepository _authenticationRepository;

  SignUp(this._authenticationRepository);

  @override
  Future<Either<AppError, bool>> call(LoginRequestParams params) async =>
      _authenticationRepository.signUp(params);
}

class LogoutUser extends UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogoutUser(this._authenticationRepository);

  @override
  Future<Either<AppError, void>> call(NoParams params) async =>
      _authenticationRepository.logoutUser();
}
