
import '../../domain/entity/weather_by_hours_entity.dart';

class WeatherByHoursModel extends WeatherByHoursEntity {
  const WeatherByHoursModel({
    required super.temp,
    required super.millisecondsFromEpoch,
    required super.type,
  });

  factory WeatherByHoursModel.fromJson(Map<String, dynamic> json) {
    return WeatherByHoursModel(
      temp: json['temp'],
      millisecondsFromEpoch: json['dt'] ,
      type:  json['weather'][0]['main'] ,
    );
  }
  factory WeatherByHoursModel.fromEntity(WeatherByHoursEntity entity) {
    return WeatherByHoursModel(
      temp: entity.temp,
      millisecondsFromEpoch: entity.millisecondsFromEpoch,
      type: entity.type,
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['temp'] = temp;
    data['dt'] = millisecondsFromEpoch;
    data['weather'] = [
      {'main': type}
    ];
    return data;
  }
}
