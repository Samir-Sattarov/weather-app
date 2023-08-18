part of 'sign_up_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();
}

class SignUpInitial extends SignUpState {
  @override
  List<Object> get props => [];
}class SignUpLoading extends SignUpState {
  @override
  List<Object> get props => [];
}
class SignUpError extends SignUpState {
  final String message;

  const SignUpError(this.message);

  @override
  List<Object> get props => [message];
}

class SignUpSuccess extends SignUpState {
  @override
  List<Object> get props => [];
}
