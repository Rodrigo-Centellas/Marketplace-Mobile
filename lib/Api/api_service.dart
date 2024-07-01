// api/api_service.dart
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shop_app/models/auth_response.dart';

// class ApiService {
//   static const String baseUrl = 'http://192.168.1.106:8001/api/auth/login';

//   Future<AuthResponse> login(String email, String password) async {
//     final response = await http.post(
//       Uri.parse(baseUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'email': email, 'password': password}),
//     );

//     if (response.statusCode == 200) {
//       return AuthResponse.fromJson(jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to login');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'token_storage_service.dart';
import '../const/API_URL.dart';

class ApiService {
  // final String apiUrl = 'http://192.168.1.106:8001/api/auth/login';
final String apiUrl = '${API_URL.apiUrl}/api/auth/login';
  Future<AuthResponse> login(String email, String password) async {
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
      final userId = data['user']['id'].toString(); // Asegúrate de que esta ruta es correcta en tu respuesta JSON
      await TokenStorageService.saveToken(token);
      await TokenStorageService.saveUserId(userId);
      return AuthResponse(accessToken: token, userId: userId);
    } else {
      throw Exception('Failed to login');
    }
  }
}

class AuthResponse {
  final String accessToken;
  final String userId;

  AuthResponse({required this.accessToken, required this.userId});
}
