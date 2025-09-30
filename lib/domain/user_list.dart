import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:task_1/domain/user.dart';

class UserList extends Equatable {
  final List<User> users;

  const UserList({
    required this.users,
  });

  UserList copyWith({
    List<User>? users,
  }) {
    return UserList(
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'users': users.map((x) => x.toMap()).toList(),
    };
  }

  factory UserList.fromMap(Map<String, dynamic> map) {
    return UserList(
      users: List<User>.from(map['users']?.map((x) => User.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserList.fromJson(String source) =>
      UserList.fromMap(json.decode(source));

  @override
  String toString() => 'UserList(users: $users)';

  @override
  List<Object> get props => [users];
}
