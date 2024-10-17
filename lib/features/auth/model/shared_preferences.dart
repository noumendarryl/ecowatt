import 'package:shared_preferences/shared_preferences.dart';
import 'user_model.dart';

class UserPreferences {
  static const _keyUserId = 'userId';
  static const _keyUserEmail = 'userEmail';

  Future<void> saveUserModel(UserModel model) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, model.userId);
    await prefs.setString(_keyUserEmail, model.email);
  }

  Future<UserModel?> getUserModel() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(_keyUserId);
    final userEmail = prefs.getString(_keyUserEmail);
    if (userId != null && userEmail != null) {
      return UserModel(userId: userId, email: userEmail);
    }
    return null;
  }

  Future<void> clearUserModel() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserEmail);
  }
}
