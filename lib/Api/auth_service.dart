import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_storage_service.dart';
import '../const/API_URL.dart';

class AuthService {
  // final String apiUrl = 'http://192.168.1.106:8001/api/auth/login';
final String apiUrl = '${API_URL.apiUrl}/api/auth/login';
  Future<String?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final token = data['access_token'];
      final userId = data['user']['id'].toString();
      await TokenStorageService.saveToken(token);
      await TokenStorageService.saveUserId(userId);
      return token;
    } else {
      throw Exception('Failed to login');
    }
  }
}
