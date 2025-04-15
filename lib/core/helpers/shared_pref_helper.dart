import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _isUserLoginKey = 'isUserLogin';
  static const String _tokenKey = 'token';
  

  /// Save login state
  static Future<void> setUserLoggedIn(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isUserLoginKey, isLoggedIn);
  }

  /// Get login state
  static Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isUserLoginKey) ?? false;
  }

  /// Save token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  /// Get token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// Clear all saved user data (e.g., on logout)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isUserLoginKey);
    await prefs.remove(_tokenKey);
  }
}
