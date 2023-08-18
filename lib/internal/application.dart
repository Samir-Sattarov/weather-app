import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../features/auth/presentation/cubit/auth/auth_cubit.dart';
import '../features/auth/presentation/cubit/login_cubit.dart';
import '../features/auth/presentation/screens/on_boarding_screen.dart';
import '../features/main/presensation/screens/home_screen.dart';
import '../locator/locator.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late LoginCubit _loginCubit;
  late AuthCubit _authCubit;

  @override
  void initState() {
    _loginCubit = locator();
    _authCubit = locator();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _authCubit..userIsAuth()),
        BlocProvider.value(value: _loginCubit),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            title: 'Weather app',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.blue,
            ),
            home: child,
          );
        },
        child: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            print("Auth state $state");
            if (state is UserIsNotLoggedIn) {
              return const HomeScreen();
            } else if (state is UserIsLoggedIn) {
              return const HomeScreen();
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
