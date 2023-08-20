import 'package:flutter/material.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_constants.dart';
import '../../domain/entities/login_request_params.dart';

abstract class AuthenticationRemoteDataSource {
  Future<String> signIn(LoginRequestParams params);
  Future<bool> signUp(LoginRequestParams params);
}

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  // final FirebaseAuthentication _client;
  final ApiClient _client;

  AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<String> signIn(LoginRequestParams params) async {
    final Map<String, dynamic> response = await _client.post(
      ApiConstants.signIn,
      params: {
        "email": params.email,
        "returnSecureToken": true,
        "password": params.password,
      },
      withBaseUrl: false,
      isFirebase: true,
    );

    debugPrint("Validate login $response");

    final token = response["idToken"];
    return token;
  }

  @override
  Future<bool> signUp(LoginRequestParams params) async {
    await _client.post(
      ApiConstants.signUp,
      params: {
        "email": params.email,
        "returnSecureToken": true,
        "password": params.password,
      },
      withBaseUrl: false,
      isFirebase: true,
    );

    return true;
  }
}
