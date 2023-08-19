import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entity/weather_by_hours_entity.dart';

class WeatherByHoursModel extends WeatherByHoursEntity {
  const WeatherByHoursModel({
    required super.temp,
    required super.millisecondsFromEpoch,
    required super.type,
  });

  factory WeatherByHoursModel.fromJson(Map<String, dynamic> json) {
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

    return WeatherByHoursModel(
      temp: json['temp'],
      millisecondsFromEpoch: json['dt'].toString(),
      type: json['weather'][0]['main'],
    );
  }
}
