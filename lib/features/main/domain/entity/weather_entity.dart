import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_by_hours_entity.dart';

class WeatherEntity extends Equatable {
  final int degrees;
  final int maxDegrees;
  final int minDegrees;
  final String hour;
  final int windy;
  final int humidity;
  final WeatherType type;
  final List<WeatherByHoursEntity> weatherByHours;
  final String windDirection;
  final String humidityInfo;

  const WeatherEntity({
    required this.degrees,
    required this.hour,
    required this.type,
    required this.maxDegrees,
    required this.minDegrees,
    required this.windy,
    required this.humidity,
    required this.windDirection,
    required this.weatherByHours,
    required this.humidityInfo,
  });

  factory WeatherEntity.empty() {
    return const WeatherEntity(
      degrees: 20,
      hour: "15:00",
      type: WeatherType.rain,
      windy: 1,
      humidity: 3,
      windDirection: "windDirection",
      humidityInfo: "humidityInfo",
      weatherByHours: [
        WeatherByHoursEntity(
            degrees: 20, hour: "8:00", type: WeatherType.sunny),
        WeatherByHoursEntity(
            degrees: 30, hour: "8:00", type: WeatherType.storm),
      ],
      maxDegrees: 30,
      minDegrees: 20,
    );
  }

  @override
  List<Object?> get props => [degrees, hour, type];
}

enum WeatherType {
  sunny,
  rain,
  storm,
  sunWithClouds,
  moonWithClouds,
}
