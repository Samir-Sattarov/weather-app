import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/entities/login_request_params.dart';
import '../../../domain/usecases/login_user.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUp signUpUsecase;
  SignUpCubit(this.signUpUsecase) : super(SignUpInitial());

  void signUp(String email, String password) async {
    final eitherResponse = await signUpUsecase(
      LoginRequestParams(
        email: email,
        password: password,
      ),
    );

    eitherResponse.fold(
      (l) {
        final message = l.errorMessage;
        debugPrint("Sign up error $message");
        emit(SignUpError(message));
      },
      (r) {
        debugPrint("Sign up success $r");
        emit(SignUpSuccess());
      },
    );
  }
}
