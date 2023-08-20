import 'package:flutter_weather_app/features/main/domain/entity/weather_entity.dart';

import 'weather_by_hours_model.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required super.temp,
    required super.city,
    required super.type,
    required super.maxDegrees,
    required super.minDegrees,
    required super.windySpeed,
    required super.humidity,
    required super.listWeatherByHours,
    required super.windDirection,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: json['current']['temp'],
      type: json['current']['weather'][0]['main'],
      city: json['timezone'],
      maxDegrees: json['daily'][0]['temp']['max'],
      minDegrees: json['daily'][0]['temp']['min'],
      windySpeed: json['current']['wind_speed'],
      humidity: json['current']['humidity'],
      listWeatherByHours: List.from(json['hourly'])
          .map((e) => WeatherByHoursModel.fromJson(Map<String,dynamic>.from(e)))
          .toList(),
      windDirection: json['current']['wind_deg'],
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
      listWeatherByHours: entity.listWeatherByHours,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'current': {
        'temp': temp,
        'weather': [
          {
            'main': type,
          }
        ],
        'wind_speed': windySpeed,
        'humidity': humidity,
        'wind_deg': windDirection,
      },
      'timezone': city,
      'daily': [
        {
          'temp': {'max': maxDegrees, 'min': minDegrees},
        },
        // здесь могут быть другие элементы daily
      ],
      'hourly': listWeatherByHours.map((e) {
        final model = WeatherByHoursModel.fromEntity(e);

        return model.toJson();
      }).toList(),
    };
  }
}
