import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/login_request_params.dart';
import '../repositories/authentication_repository.dart';

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
