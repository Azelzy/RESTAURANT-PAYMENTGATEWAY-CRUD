import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // Keys
  static const String keyToken = 'token';
  static const String keyUsername = 'username';
  static const String keyEmail = 'email';
  static const String keyPhotoUrl = 'photo_url';
  static const String keyLoginType = 'login_type'; // 'api' or 'google'

  // ========== SAVE DATA ==========
  
  /// Simpan token
  static Future<bool> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(keyToken, token);
  }

  /// Simpan username
  static Future<bool> saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(keyUsername, username);
  }

  /// Simpan email
  static Future<bool> saveEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(keyEmail, email);
  }

  /// Simpan photo URL
  static Future<bool> savePhotoUrl(String photoUrl) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(keyPhotoUrl, photoUrl);
  }

  /// Simpan login type
  static Future<bool> saveLoginType(String loginType) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.setString(keyLoginType, loginType);
  }

  /// Simpan login data (token + username)
  static Future<bool> saveLoginData(String token, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyToken, token);
    await prefs.setString(keyUsername, username);
    await prefs.setString(keyLoginType, 'api');
    return true;
  }

  /// Simpan Google login data
  static Future<bool> saveGoogleLoginData({
    required String email,
    required String username,
    String? photoUrl,
    String? token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyEmail, email);
    await prefs.setString(keyUsername, username);
    await prefs.setString(keyLoginType, 'google');
    if (photoUrl != null) {
      await prefs.setString(keyPhotoUrl, photoUrl);
    }
    if (token != null) {
      await prefs.setString(keyToken, token);
    }
    return true;
  }

  // ========== GET DATA ==========
  
  /// Ambil token
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyToken);
  }

  /// Ambil username
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUsername);
  }

  /// Ambil email
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyEmail);
  }

  /// Ambil photo URL
  static Future<String?> getPhotoUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyPhotoUrl);
  }

  /// Ambil login type
  static Future<String?> getLoginType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyLoginType);
  }

  /// Cek apakah user sudah login (ada token atau email)
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(keyToken);
    final email = prefs.getString(keyEmail);
    return (token != null && token.isNotEmpty) || (email != null && email.isNotEmpty);
  }

  // ========== DELETE DATA ==========
  
  /// Hapus token
  static Future<bool> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(keyToken);
  }

  /// Hapus username
  static Future<bool> removeUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(keyUsername);
  }

  /// Hapus email
  static Future<bool> removeEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(keyEmail);
  }

  /// Hapus photo URL
  static Future<bool> removePhotoUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(keyPhotoUrl);
  }

  /// Hapus login type
  static Future<bool> removeLoginType() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(keyLoginType);
  }

  /// Hapus semua data login
  static Future<bool> clearLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyToken);
    await prefs.remove(keyUsername);
    await prefs.remove(keyEmail);
    await prefs.remove(keyPhotoUrl);
    await prefs.remove(keyLoginType);
    return true;
  }

  /// Hapus semua data di SharedPreferences
  static Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.clear();
  }

  // ========== DEBUG ==========
  
  /// Print semua data di SharedPreferences
  static Future<void> printAll() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    
    print('\n========== SHARED PREFERENCES ==========');
    if (keys.isEmpty) {
      print('No data stored');
    } else {
      for (var key in keys) {
        final value = prefs.get(key);
        print('$key: $value');
      }
    }
    print('========================================\n');
  }
}