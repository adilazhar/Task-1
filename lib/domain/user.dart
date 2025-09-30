import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String pass;
  final String email;

  const User({
    required this.pass,
    required this.email,
  });

  @override
  String toString() {
    return 'User{ pass: $pass, email: $email}';
  }

  @override
  List<Object?> get props => [pass, email];

  User copyWith({
    String? pass,
    String? email,
  }) {
    return User(
      pass: pass ?? this.pass,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': pass,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      pass: map['pass'] ?? '',
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
