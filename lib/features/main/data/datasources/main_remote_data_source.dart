
import 'package:flutter_weather_app/core/api/api_constants.dart';

import '../../../../core/api/api_client.dart';
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
      "${ApiConstants.onecall}?lat=${lan.toStringAsFixed(2)}&units=metric&exclude=minutely&lon=${lon.toStringAsFixed(2)}&appid=${ApiConstants.weatherApiKey}&lang=ru",
      // "${ApiConstants.onecall}?lat=${39.65}&units=metric&exclude=minutely&lon=${66.97}&appid=${ApiConstants.weatherApiKey}&lang=ru",
    );
    return WeatherModel.fromJson(Map<String, dynamic>.from(response));
  }


}
