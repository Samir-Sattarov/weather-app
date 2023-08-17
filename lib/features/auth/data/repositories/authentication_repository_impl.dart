import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../../../core/api/api_exceptions.dart';
import '../../../../core/entities/app_error.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_local_data_source.dart';
import '../datasources/authentication_remote_data_source.dart';
import '../models/request_token_model.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationLocalDataSource _authenticationLocalDataSource;
  final AuthenticationRemoteDataSource _authenticationRemoteDataSource;

  AuthenticationRepositoryImpl(
    this._authenticationRemoteDataSource,
    this._authenticationLocalDataSource,
  );

  @override
  Future<Either<AppError, bool>> logginedUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();

    if (sessionId == null || sessionId.isEmpty) {
      return const Right(false);
    } else {
      return const Right(true);
    }
  }

  @override
  Future<Either<AppError, bool>> loginUser(Map<String,dynamic> model) async {
    try {
      final validateWithLoginToken =
          await _authenticationRemoteDataSource.validateWithLogin(model);

      await _authenticationLocalDataSource
          .saveSessionId(validateWithLoginToken.token);

      return const Right(true);
    } on SocketException {
      return const Left(AppError(appErrorType: AppErrorType.network));
    } on UnauthorisedException {
      return const Left(AppError(appErrorType: AppErrorType.unauthorised));
    } on ExceptionWithMessage catch (e) {
      return Left(AppError(
          appErrorType: AppErrorType.msgError, errorMessage: e.message));
    } on Exception {
      return const Left(AppError(appErrorType: AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, void>> logoutUser() async {
    final sessionId = await _authenticationLocalDataSource.getSessionId();
    if (sessionId != null) {
      await Future.wait([
        // _authenticationRemoteDataSource.deleteSession(sessionId),
        _authenticationLocalDataSource.deleteSessionId(),
      ]);
    }
    return const Right(null);
  }


}
