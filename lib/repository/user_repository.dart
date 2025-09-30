import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_1/domain/user.dart';

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
