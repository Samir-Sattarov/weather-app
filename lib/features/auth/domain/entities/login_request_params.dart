import '../../../../core/api/api_constants.dart';

class LoginRequestParams {
  final String userName;
  final String password;

  LoginRequestParams({
    required this.userName,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'user': userName,
        'pass': password,
      };
}
