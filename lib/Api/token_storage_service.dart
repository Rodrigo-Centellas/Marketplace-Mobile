import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorageService {
  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _key = 'authToken';

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _key, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _key);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _key);
  }
}
