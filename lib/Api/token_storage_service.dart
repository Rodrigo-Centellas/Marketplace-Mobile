// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class TokenStorageService {
//   static final FlutterSecureStorage _storage = FlutterSecureStorage();

//   static const String _key = 'authToken';

//   static Future<void> saveToken(String token) async {
//     await _storage.write(key: _key, value: token);
//   }

//   static Future<String?> getToken() async {
//     return await _storage.read(key: _key);
//   }

//   static Future<void> deleteToken() async {
//     await _storage.delete(key: _key);
//   }
// }
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = 'authToken';
  static const String _userIdKey = 'userId';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> saveUserId(String userId) async {
    await _storage.write(key: _userIdKey, value: userId);
  }

  static Future<String?> getUserId() async {
    return await _storage.read(key: _userIdKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userIdKey);
  }
}
