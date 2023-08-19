import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/features/main/domain/entity/weather_entity.dart';
import 'package:geolocator/geolocator.dart';

import '../../../domain/usecases/main_usecases.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final LoadWeather loadWeather;
  WeatherCubit(this.loadWeather) : super(WeatherInitial());

  load() async {
    final position = await Geolocator.getCurrentPosition();

    final data = await loadWeather.call(
      LoadWeatherParams(lan: position.latitude, lon: position.longitude),
    );

    data.fold(
      (l) {
        print("Error ${l.errorMessage } ${l.appErrorType}");
        emit(WeatherError(l.errorMessage));
      },
      (r) => emit(WeatherLoaded(entity: r)),
    );
  }

}
