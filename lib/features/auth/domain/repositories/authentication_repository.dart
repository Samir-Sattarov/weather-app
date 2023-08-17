import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../../data/models/request_token_model.dart';

abstract class AuthenticationRepository {
  Future<Either<AppError, bool>> loginUser(Map<String,dynamic> model);
  Future<Either<AppError, void>> logoutUser();
  Future<Either<AppError, bool>> logginedUser();

}
