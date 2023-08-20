import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../core/api/api_client.dart';
import '../core/api/network_info.dart';
import '../core/utils/hive_storage_service.dart';
import '../features/auth/data/datasources/authentication_local_data_source.dart';
import '../features/auth/data/datasources/authentication_remote_data_source.dart';
import '../features/auth/data/repositories/authentication_repository_impl.dart';
import '../features/auth/domain/repositories/authentication_repository.dart';
import '../features/auth/domain/usecases/auth.dart';
import '../features/auth/presentation/cubit/auth/auth_cubit.dart';
import '../features/auth/presentation/cubit/login_cubit.dart';
import '../features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';
import '../features/main/data/datasources/main_local_data_source.dart';
import '../features/main/data/datasources/main_remote_data_source.dart';
import '../features/main/data/repository/main_repository_impl.dart';
import '../features/main/domain/repository/main_repository.dart';
import '../features/main/domain/usecases/main_usecases.dart';
import '../features/main/presensation/cubit/weather/current_weather_temp/current_weather_temp_cubit.dart';
import '../features/main/presensation/cubit/weather/weather_cubit.dart';

final locator = GetIt.I;

void setup() {
  // ================ BLoC / Cubit ================ //
  locator.registerFactory(() => LoginCubit(
        signInUsecase: locator(),
        logoutUser: locator(),
      ));
  locator.registerFactory(() => SignUpCubit(
        locator(),
      ));
  locator.registerFactory(() => WeatherCubit(
        locator(),
      ));
  locator.registerFactory(() => CurrentWeatherTempCubit());

  // locator.registerFactory(() => LocaleCubit(
  // ));
  locator.registerFactory(() => AuthCubit(
        locator(),
      ));

  // ================ UseCases ================ //
  locator.registerLazySingleton<SignIn>(() => SignIn(locator()));
  locator.registerLazySingleton<SignUp>(() => SignUp(locator()));
  locator.registerLazySingleton<LogoutUser>(() => LogoutUser(locator()));
  locator.registerLazySingleton<LogginedUser>(() => LogginedUser(locator()));

  // Weather
  locator.registerLazySingleton<LoadWeather>(() => LoadWeather(locator()));

  // ================ Repository / Datasource ================ //

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
      locator(),
      locator(),
    ),
  );

  locator.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(
      locator(),
      locator(),
      locator(),
    ),
  );
  // locator.registerLazySingleton<MainRepository>(
  //       () => MainRepositoryImpl(
  //     locator(),
  //     locator(),
  //     locator(),
  //   ),
  // );

  locator.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      locator(),
    ),
  );
  locator.registerLazySingleton<AuthenticationLocalDataSource>(
    () => AuthenticationLocalDataSourceImpl(),
  );

  locator.registerLazySingleton<MainRemoteDataSource>(
    () => MainRemoteDataSourceImpl(
      locator(),
    ),
  );
  locator.registerLazySingleton<MainLocalDataSource>(
    () => MainLocalDataSourceImpl(
      locator(),
    ),
  );

  // locator.registerLazySingleton<MainRemoteDataSource>(
  //       () => MainRemoteDataSourceImpl(
  //     locator(),
  //   ),
  // );
  // locator.registerLazySingleton<MainLocalDataSource>(
  //       () => MainLocalDataSourceImpl(),
  // );

  // ================ Core ================ //

  locator.registerLazySingleton<Client>(() => Client());

  locator
      .registerLazySingleton<ApiClient>(() => ApiClient(locator(), locator()));

  // ================ External ================ //

  locator.registerLazySingleton(() => InternetConnectionChecker());

  locator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImp(locator()),
  );


  locator.registerLazySingleton<HiveStorageService>(() => HiveStorageService());
}
