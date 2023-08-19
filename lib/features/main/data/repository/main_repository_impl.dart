import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/features/main/data/datasources/main_local_data_source.dart';
import 'package:flutter_weather_app/features/main/data/datasources/main_remote_data_source.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_entity.dart';

import '../../../../core/api/api_exceptions.dart';
import '../../../../core/entities/app_error.dart';
import '../../domain/repository/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  final MainRemoteDataSource mainRemoteDataSource;
  final MainLocalDataSource mainLocalDataSource;

  MainRepositoryImpl(
    this.mainRemoteDataSource,
    this.mainLocalDataSource,
  );

  @override
  Future<Either<AppError, WeatherEntity>> loadWeather({
    required num lan,
    required num lon,
  }) async {
    try {
      final data = await mainRemoteDataSource.loadWeather(lan: lan, lon: lon);

      print("dataaaa $data");

      return Right(data);
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
}
