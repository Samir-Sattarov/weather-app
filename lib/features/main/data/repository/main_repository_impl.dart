import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_app/features/main/data/datasources/main_local_data_source.dart';
import 'package:flutter_weather_app/features/main/data/datasources/main_remote_data_source.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_by_hours_result_entity.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_entity.dart';

import '../../../../core/api/api_exceptions.dart';
import '../../../../core/api/network_info.dart';
import '../../../../core/entities/app_error.dart';
import '../../domain/repository/main_repository.dart';

class MainRepositoryImpl implements MainRepository {
  final MainRemoteDataSource mainRemoteDataSource;
  final MainLocalDataSource mainLocalDataSource;
  final NetworkInfo networkInfo;

  MainRepositoryImpl(
    this.mainRemoteDataSource,
    this.mainLocalDataSource,
    this.networkInfo,
  );

  @override
  Future<Either<AppError, WeatherEntity>> loadWeather({
    required num lan,
    required num lon,
  }) async {
    try {
      final connected = await networkInfo.isConnected;
      debugPrint("Connected $connected");
      if (connected) {
        final data = await mainRemoteDataSource.loadWeather(lan: lan, lon: lon);

        await mainLocalDataSource.saveWeather(data);
        return Right(data);
      } else {
        final data = await mainLocalDataSource.loadWeather();
        if (data == null) {
          return const Left(
            AppError(
              appErrorType: AppErrorType.msgError,
              errorMessage: "hasntDataAndConnection",
            ),
          );
        }
        return Right(data);
      }
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
