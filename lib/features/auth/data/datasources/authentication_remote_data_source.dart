import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_weather_app/core/api/api_exceptions.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/api/api_constants.dart';
import '../../../../core/api/firebase_auth.dart';
import '../../domain/entities/login_request_params.dart';
import '../models/token_model.dart';

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

    print("Validate login $response");

    final token = response["idToken"];
    return token;
  }

  @override
  Future<bool> signUp(LoginRequestParams params) async {
    final response = await _client.post(ApiConstants.signUp, params: {
      "email": params.email,
      "returnSecureToken": true,
      "password": params.password,
    },      withBaseUrl: false,
      isFirebase: true,);

    return true;
  }
}
