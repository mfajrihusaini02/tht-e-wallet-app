import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? email;
  final String? firstName;
  final String? lastName;
  static String? token;

  const User({
    this.email,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson(Map<String, dynamic> data) => User(
        email: data['email'],
        firstName: data['first_name'],
        lastName: data['last_name'],
      );

  User copyWith({
    String? email,
    String? firstName,
    String? lastName,
  }) {
    return User(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  List<Object?> get props => [email, firstName, lastName];
}
