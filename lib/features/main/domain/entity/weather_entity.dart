import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_by_hours_entity.dart';

import 'weather_by_hours_result_entity.dart';

class WeatherEntity extends Equatable {
  final num temp;
  final num maxDegrees;
  final num minDegrees;
  final String city;
  final num windySpeed;
  final int humidity;
  final String type;
  final List<WeatherByHoursEntity> listWeatherByHours;
  final num windDirection;

  const WeatherEntity({
    required this.temp,
    required this.city,
    required this.type,
    required this.maxDegrees,
    required this.minDegrees,
    required this.windySpeed,
    required this.humidity,
    required this.listWeatherByHours,
    required this.windDirection,
  });

  factory WeatherEntity.empty() {
    return const WeatherEntity(
      temp: 20,
      city: "Архангельск Россия",
      type: "Rain",
      windySpeed: 10,
      humidity: 100,
      listWeatherByHours:[],
      windDirection: 40,
      maxDegrees: 30,
      minDegrees: 20,
    );
  }

  @override
  List<Object?> get props => [temp, type];
}

enum WeatherType {
  thunderstorm,
  drizzle,
  rain,
  snow,
  clear,
  clouds,
}
