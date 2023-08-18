import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'api_constants.dart';


class FirebaseClient {
  final _fireAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _fireStorage = FirebaseStorage.instance;


  //
  //
  // Future<DocumentSnapshot<Map<String, dynamic>>?>? fetchUserData({
  //   required String collectionName,
  //   required String doc,
  // }) async {
  //   final user = getCurrentUser();
  //
  //   if (user != null) {
  //     final response =
  //     await _fireStore.collection(collectionName).doc(user.uid).get();
  //     return response;
  //   }
  //
  //   return null;
  // }

}
