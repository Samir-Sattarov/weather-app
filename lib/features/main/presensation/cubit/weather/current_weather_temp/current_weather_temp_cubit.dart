import 'package:bloc/bloc.dart';


class CurrentWeatherTempCubit extends Cubit<num> {
  CurrentWeatherTempCubit() : super(0);

  set(num temp) {
    emit(temp);
  }
}
