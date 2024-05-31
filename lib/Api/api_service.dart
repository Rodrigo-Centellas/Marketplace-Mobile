// api/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/auth_response.dart';

class ApiService {
  static const String baseUrl = 'https://jose-test.site/api/auth/login';

  Future<AuthResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return AuthResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login');
    }
  }
}
