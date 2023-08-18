import 'package:flutter_weather_app/core/api/firebase_auth.dart';
import 'package:flutter_weather_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../core/api/api_client.dart';
import '../features/auth/data/datasources/authentication_local_data_source.dart';
import '../features/auth/data/datasources/authentication_remote_data_source.dart';
import '../features/auth/data/repositories/authentication_repository_impl.dart';
import '../features/auth/domain/repositories/authentication_repository.dart';
import '../features/auth/domain/usecases/auth.dart';
import '../features/auth/domain/usecases/login_user.dart';
import '../features/auth/domain/usecases/logout_user.dart';
import '../features/auth/presentation/cubit/auth/auth_cubit.dart';
import '../features/auth/presentation/cubit/sign_up/sign_up_cubit.dart';

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

  // locator.registerFactory(() => LocaleCubit(
  // ));
  locator.registerFactory(() => AuthCubit(
        locator(),
      ));

  // ================ UseCases ================ //
  locator.registerLazySingleton<SignIn>(() => SignIn(locator()));
  locator.registerLazySingleton<SignUp>(() => SignUp(locator()));
  locator.registerLazySingleton<LogoutUser>(() => LogoutUser(locator()));

  // User
  locator.registerLazySingleton<LogginedUser>(() => LogginedUser(locator()));

  // ================ Repository / Datasource ================ //

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(
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
      .registerLazySingleton<ApiClient>(() => ApiClient(locator(), locator())); locator
      .registerLazySingleton<FirebaseAuthentication>(() => FirebaseAuthentication());

  // ================ External ================ //
}
