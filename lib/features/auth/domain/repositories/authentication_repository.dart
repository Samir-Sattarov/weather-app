import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../data/models/request_token_model.dart';
import '../entities/login_request_params.dart';

abstract class AuthenticationRepository {
  Future<Either<AppError, bool>> signIn(LoginRequestParams params);
  Future<Either<AppError, bool>> signUp(LoginRequestParams params);
  Future<Either<AppError, void>> logoutUser();
  Future<Either<AppError, bool>> logginedUser();

}
