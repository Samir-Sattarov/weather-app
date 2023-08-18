import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

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
  final FirebaseAuthentication _client;

  AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<String> signIn(LoginRequestParams params) async {
    final response = await _client.signInWithEmail(
      email: params.email,
      password: params.password,
    );

    log(response.toString(), name: "Token");

    print("Validate login $response");

    return response;
  }
  @override
  Future<bool> signUp(LoginRequestParams params) async {
    final response = await _client.signUp(
      email: params.email,
      password: params.password,
    );



    return response;
  }
}
