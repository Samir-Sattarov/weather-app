import 'package:equatable/equatable.dart';

import 'weather_entity.dart';

class WeatherByHoursEntity extends Equatable {
  final int degrees;
  final String hour;
  final WeatherType type;

  const WeatherByHoursEntity(
      {required this.degrees, required this.hour, required this.type});

  factory WeatherByHoursEntity.empty() {
    return const WeatherByHoursEntity(
      degrees: 23,
      hour: "15:00",
      type: WeatherType.rain,
    );
  }

  @override
  List<Object?> get props => [degrees, hour, type];
}
