import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  // final num lan;
  // final num lon;

  const UserEntity({
    required this.uid,
    required this.email,
    // required this.lan,
    // required this.lon,
  });

  @override
  List<Object?> get props => [
        email,
        // lan,
        // lon,
      ];
}
