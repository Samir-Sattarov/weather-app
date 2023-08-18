import 'package:equatable/equatable.dart';
import 'package:flutter_weather_app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    // required super.lan,
    // required super.lon
  });

  factory UserModel.fromJson({
    required Map<String, dynamic> json,
    required String locale,
  }) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      // lan: json['lan'],
      // lon: json['lon'],
    );
  }
  factory UserModel.fromEntity({
    required UserEntity entity,
  }) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      // lan: entity.lan,
      // lon: entity.lon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      // "lan": lan,
      // "lon": lon,
    };
  }
}
