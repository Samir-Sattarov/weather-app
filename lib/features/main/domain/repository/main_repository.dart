import 'package:dartz/dartz.dart';

import '../../../../core/entities/app_error.dart';
import '../entity/weather_by_hours_result_entity.dart';
import '../entity/weather_entity.dart';

abstract class MainRepository {
  Future<Either<AppError, WeatherEntity>> loadWeather({required num lan, required num lon});

}
