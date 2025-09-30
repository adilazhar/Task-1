import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/domain/user.dart';
import 'package:task_1/domain/user_list.dart';
import 'package:task_1/providers/shared_preferences.dart';

part 'user_repository.g.dart';

class UserRepository {
  final String _usersKey = 'users';
  final String _currentUserKey = 'current_user';
  final SharedPreferencesAsync _preferences;

  UserRepository(this._preferences);

  // addUser(User user)
  Future<void> addUser(User user) async {
    final allUsers = await getAllUsers();
    log('All users before adding: ${allUsers.toJson()}');
    final updatedUsers = allUsers.copyWith(
      users: [...allUsers.users, user],
    );
    log('Updated users: ${updatedUsers.toJson()}');
    await _preferences.setString(_usersKey, updatedUsers.toJson());
    await setCurrentUser(user);
  }

  // getCurrentUser()
  Future<User?> getCurrentUser() async {
    final currentUserJson = await _preferences.getString(_currentUserKey);
    if (currentUserJson == null) return null;
    return User.fromJson(currentUserJson);
  }

  // setCurrentUser(User user)
  Future<void> setCurrentUser(User user) async {
    // fetch all users to ensure the user exists
    final allUsers = await getAllUsers();
    log('All users before Setting Current User: ${allUsers.toJson()}');

    final userExists = allUsers.users.any(
      (u) => u.email == user.email && u.pass == user.pass,
    );
    if (!userExists) {
      throw Exception('User does not exist');
    }
    await _preferences.setString(_currentUserKey, user.toJson());
  }

  // clearCurrentUser()
  Future<void> clearCurrentUser() async {
    await _preferences.setString(_currentUserKey, '');
  }

  // deleteUser(String email)
  Future<void> deleteUser(String email) async {
    final allUsers = await getAllUsers();
    final updatedUsers = allUsers.copyWith(
      users: allUsers.users.where((user) => user.email != email).toList(),
    );
    await _preferences.setString(_usersKey, updatedUsers.toJson());
    final currentUser = await getCurrentUser();
    if (currentUser != null && currentUser.email == email) {
      await clearCurrentUser();
    }
  }

  // getAllUsers()
  Future<UserList> getAllUsers() async {
    final allUsersJson = await _preferences.getString(_usersKey);
    if (allUsersJson == null) {
      return const UserList(users: []);
    }
    return UserList.fromJson(allUsersJson);
  }
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  final preferences = ref.watch(sharedPrefProvider);
  return UserRepository(preferences);
}
