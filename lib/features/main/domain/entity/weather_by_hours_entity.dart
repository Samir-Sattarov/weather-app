import 'package:equatable/equatable.dart';


class WeatherByHoursEntity extends Equatable {
  final num temp;
  final int millisecondsFromEpoch;
  final String type;

  const WeatherByHoursEntity({
    required this.temp,
    required this.millisecondsFromEpoch,
    required this.type,
  });

  factory WeatherByHoursEntity.empty() {
    return WeatherByHoursEntity(
      temp: 23,
      millisecondsFromEpoch: DateTime.now().millisecondsSinceEpoch,
      type: "Clear",
    );
  }

  @override
  List<Object?> get props => [temp, millisecondsFromEpoch, type];
}
