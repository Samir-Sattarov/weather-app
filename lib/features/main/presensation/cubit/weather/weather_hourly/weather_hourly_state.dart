part of 'weather_hourly_cubit.dart';

abstract class WeatherHourlyState extends Equatable {
  const WeatherHourlyState();
}

class WeatherHourlyInitial extends WeatherHourlyState {
  @override
  List<Object> get props => [];
}
