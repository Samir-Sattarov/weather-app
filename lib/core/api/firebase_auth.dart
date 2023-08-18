import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'api_exceptions.dart';

class FirebaseAuthentication {
  final _fireAuth = FirebaseAuth.instance;

  Future<bool> signUp({
    required String email,
    required String password,
    // required num lon,
    // required num lan,
  }) async {
    UserCredential credential = await _fireAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );




    return true;
  }

  Future<String> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final token = result.user!.refreshToken;

      return token!;
    } catch (e) {
      debugPrint("Error during sign in: $e");
      if(e.toString().contains("user-not-found")) {
        throw UnauthorisedException();
      }

      throw Exception();

    }
  }

  // User? getCurrentUser() {
  //   final user = _fireAuth.currentUser;
  //
  //   return user;
  // }
}
