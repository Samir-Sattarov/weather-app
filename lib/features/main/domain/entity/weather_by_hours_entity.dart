import 'package:equatable/equatable.dart';

import 'weather_entity.dart';

class WeatherByHoursEntity extends Equatable {
  final num temp;
  final String millisecondsFromEpoch;
  final String type;

  const WeatherByHoursEntity({
    required this.temp,
    required this.millisecondsFromEpoch,
    required this.type,
  });

  factory WeatherByHoursEntity.empty() {

    /*
    {
      "dt":1692439200;
    "temp":289.21;
    "feels_like":289.04;
    "pressure":1008;
    "humidity":83;
    "dew_point":286.33;
    "uvi":0;
    "clouds":0;
    "visibility":10000;
    "wind_speed":0.77;
    "wind_deg":215;
    "wind_gust":0.92;
    "weather":[
     {
               "id":800,
               "main":"Clear",
               "description":"clear sky",
               "icon":"01n"
            }
            ];
    "pop":0;
  };

  */

    return const WeatherByHoursEntity(
      temp: 23,
      millisecondsFromEpoch: "15:00",
      type: "Clear",
    );
  }

  @override
  List<Object?> get props => [temp, millisecondsFromEpoch, type];
}
