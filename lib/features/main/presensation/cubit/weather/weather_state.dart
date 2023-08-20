part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}


class WeatherServiceNotWorking extends WeatherState {
  @override
  List<Object> get props => [];
}class WeatherHasntData extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final WeatherEntity entity;

  const WeatherLoaded({required this.entity});
  @override
  List<Object> get props => [entity];
}
