import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'weather_hourly_state.dart';

class WeatherHourlyCubit extends Cubit<WeatherHourlyState> {
  WeatherHourlyCubit() : super(WeatherHourlyInitial());
}
