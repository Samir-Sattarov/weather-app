import 'package:flutter_weather_app/features/main/domain/entity/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.temp,
    required super.city,
    required super.type,
    required super.maxDegrees,
    required super.minDegrees,
    required super.windySpeed,
    required super.humidity,
    required super.windDirection,
    required super.weatherByHours,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp:  json['current']['temp'],
      type: json['current']['weather'][0]['main'],
      city: json['timezone'],
      maxDegrees:json['daily'][0]['temp']['max'],
      minDegrees: json['daily'][0]['temp']['min'],
      windySpeed: json['current']['wind_speed'],
      humidity:  json['current']['humidity'],
      windDirection:  json['current']['wind_deg'],
      weatherByHours: [],
    );
  }

  factory WeatherModel.fromEntity(WeatherEntity entity) {
    return WeatherModel(
      temp: entity.temp,
      city: entity.city,
      type: entity.type,
      maxDegrees: entity.maxDegrees,
      minDegrees: entity.minDegrees,
      windySpeed: entity.windySpeed,
      humidity: entity.humidity,
      windDirection: entity.windDirection,
      weatherByHours: entity.weatherByHours,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "temp": temp,
      "city": city,
      "type": type,
      "max_degrees": maxDegrees,
      "min_degrees": minDegrees,
      "windy_speed": windySpeed,
      "humidity": humidity,
      "wind_direction": windDirection,
      "weather_by_hours": weatherByHours
    };
  }

}
