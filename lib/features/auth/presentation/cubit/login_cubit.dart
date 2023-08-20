import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/entities/no_params.dart';
import '../../domain/entities/login_request_params.dart';
import '../../domain/usecases/auth.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignIn signInUsecase;
  final LogoutUser logoutUser;

  LoginCubit({
    required this.signInUsecase,
    required this.logoutUser,
  }) : super(LoginInitial());

  void init() {
    emit(LoginInitial());
  }

  void signIn(String email, String password) async {
    final eitherResponse = await signInUsecase(
      LoginRequestParams(
        email: email,
        password: password,
      ),
    );

    eitherResponse.fold(
      (l) {
        debugPrint("Error ${l.errorMessage}");



        if (l.errorMessage.contains("INVALID_PASSWORD")) {
          emit(const LoginError("userIsNotFound"));
          return ;
        }
          emit(LoginError(l.errorMessage));

      },
      (r) {
        debugPrint("Login Success $r");
        emit(LoginSuccess());
      },
    );
  }

  void logout() async {
    await logoutUser(NoParams());
    emit(LogoutSuccess());
  }
}
