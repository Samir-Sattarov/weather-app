
class LoginRequestParams {
  final String email;
  final String password;

  LoginRequestParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}
