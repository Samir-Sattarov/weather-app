import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_weather_app/core/api/api_constants.dart';

import '../../../../core/api/api_client.dart';
import '../../domain/entity/weather_entity.dart';
import '../model/weather_model.dart';

abstract class MainRemoteDataSource {
  Future<WeatherModel> loadWeather({required num lan, required num lon});
}

class MainRemoteDataSourceImpl extends MainRemoteDataSource {
  final ApiClient _client;

  MainRemoteDataSourceImpl(this._client);

  @override
  Future<WeatherModel> loadWeather({required num lan, required num lon}) async {
    final response = await _client.get(
      "${ApiConstants.weather}?lat=${lan.toStringAsFixed(2)}&units=metric&exclude=minutely&lon=${lon.toStringAsFixed(2)}&appid=${ApiConstants.weatherApiKey}",
    );
    // log("Response Weather $response");

    return WeatherModel.fromJson(Map<String,dynamic>.from(response));
  }
}
