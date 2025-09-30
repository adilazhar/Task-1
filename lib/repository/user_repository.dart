import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/domain/user.dart';
import 'package:task_1/providers/shared_preferences.dart';

part 'user_repository.g.dart';

class UserRepository {
  final String _userKey = 'user';
  final SharedPreferencesAsync _preferences;

  UserRepository(this._preferences);

  Future<User?> getUser() async {
    final userJson = await _preferences.getString(_userKey);
    if (userJson == null) return null;
    return User.fromJson(userJson);
  }

  Future<void> saveUser(User user) async {
    final userJson = user.toJson();
    await _preferences.setString(_userKey, userJson);
  }

  Future<void> deleteUser() async {
    await _preferences.remove(_userKey);
  }
}

@Riverpod(keepAlive: true)
UserRepository userRepository(Ref ref) {
  final preferences = ref.watch(sharedPrefProvider);
  return UserRepository(preferences);
}
