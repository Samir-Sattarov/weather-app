import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import '../../../../core/entities/no_params.dart';
import '../../domain/entities/login_request_params.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  // final CurrentUserCubit currentUserCubit;

  //final UserGetSmsForNewNumber userGetSmsForNewNumber;
  //final RestorePassword restorePassword;
  LoginCubit({
    required this.loginUser,
    required this.logoutUser,
    // required this.loadingCubit,
    // required this.currentUserCubit,
    //required this.userGetSmsForNewNumber,
    //required this.restorePassword,
  }) : super(LoginInitial());

  void init() {
    emit(LoginInitial());
  }



  void initiateLogin(
      String username, String password, bool remember) async {
    log("Sign in method");
    final eitherResponse = await loginUser(
      LoginRequestParams(
        userName: username,
        password: password,
      ),
    );

    eitherResponse.fold(
      (l) {
        print("Error ${l.errorMessage}");
        final message = l.errorMessage;

        if (message.contains("\"code\":403")) {
          emit(const LoginError("wrongPasswordOrUserName"));
        } else {
          emit(LoginError(message));
        }
      },
      (r) {
        print("Login Success $r");
        emit(LoginSuccess());
      },
    );
  }

  void logout() async {
    await logoutUser(NoParams());
    emit(LogoutSuccess());
  }
}
