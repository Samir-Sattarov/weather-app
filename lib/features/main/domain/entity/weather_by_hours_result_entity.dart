import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_by_hours_entity.dart';

class WeatherByHoursResultEntity extends Equatable {
  final List<WeatherByHoursEntity> weatherByHours;

  const WeatherByHoursResultEntity({required this.weatherByHours});

  @override
  List<Object?> get props => [
        weatherByHours,
      ];
}
