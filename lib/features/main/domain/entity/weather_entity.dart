import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_by_hours_entity.dart';

class WeatherEntity extends Equatable {
  final num temp;
  final num maxDegrees;
  final num minDegrees;
  final String city;
  final num windySpeed;
  final int humidity;
  final String type;
  final List<WeatherByHoursEntity> weatherByHours;
  final num windDirection;

  const WeatherEntity({
    required this.temp,
    required this.city,
    required this.type,
    required this.maxDegrees,
    required this.minDegrees,
    required this.windySpeed,
    required this.humidity,
    required this.windDirection,
    required this.weatherByHours,
  });

  factory WeatherEntity.empty() {
    return const WeatherEntity(
      temp: 20,
      city: "Архангельск Россия",
      type: "Rain",
      windySpeed: 1,
      humidity: 3,
      windDirection: 40,
      weatherByHours: [
        // WeatherByHoursEntity(
        //     degrees: 20, hour: "8:00", type: WeatherType.sunny),
        // WeatherByHoursEntity(
        //     degrees: 30, hour: "8:00", type: WeatherType.storm),
      ],
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
