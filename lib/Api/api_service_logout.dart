import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://jose-test.site/api/auth';

  Future<void> logout(String token) async {
    final url = Uri.parse('$baseUrl/logout');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to logout');
    }
  }
}
