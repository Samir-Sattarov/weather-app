import 'dart:developer';
import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_constants.dart';
import '../models/token_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<TokenModel> validateWithLogin(Map<String, dynamic> requestBody);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final ApiClient _client;

  AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<TokenModel> validateWithLogin(
    Map<String, dynamic> requestBody,
  ) async {
    final response = await _client.post(
      ApiConstants.signIn,
      withToken: false,
      params: requestBody,
    );

    log(response.toString(), name: "Token");

    print("Validate login");

    return TokenModel.fromJson(response);
  }
}
