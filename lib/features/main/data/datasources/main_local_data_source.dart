import 'package:flutter/material.dart';
import 'package:flutter_weather_app/core/utils/storage_service.dart';
import 'package:flutter_weather_app/features/main/data/model/weather_model.dart';

abstract class MainLocalDataSource {
  Future<WeatherModel> saveWeather(WeatherModel model);
  Future<WeatherModel?> loadWeather();
  Future<void> deleteWeather();
}

class MainLocalDataSourceImpl extends MainLocalDataSource {
  final HiveStorageService storageService;

  MainLocalDataSourceImpl(this.storageService);
  @override
  Future<void> deleteWeather() async {}

  @override
  Future<WeatherModel?> loadWeather() async {
    final json =
        await storageService.fetch(key: "weather", boxKey: "weatherBox");

    if (json == null) return null;

    final model = WeatherModel.fromJson(Map<String,dynamic>.from(json));

    return model;
  }

  @override
  Future<WeatherModel> saveWeather(WeatherModel model) async {
    await storageService.save(
      key: "weather",
      boxKey: "weatherBox",
      value: model.toJson(),
    );
    debugPrint("Succes saved to local storage!!");

    return model;
  }
}
