import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_entity.dart';
import 'package:flutter_weather_app/features/main/domain/repository/main_repository.dart';

import '../../../../core/entities/app_error.dart';
import '../../../../core/entities/no_params.dart';
import '../../../../core/usecases/usecase.dart';

class LoadWeather extends UseCase<WeatherEntity, LoadWeatherParams> {
  final MainRepository _mainRepository;

  LoadWeather(this._mainRepository);

  @override
  Future<Either<AppError, WeatherEntity>> call(LoadWeatherParams params) =>
      _mainRepository.loadWeather(lan: params.lan,lon: params.lon);
}

class LoadWeatherParams {
  final num lan;
  final num lon;

  LoadWeatherParams({required this.lan, required this.lon});
}
