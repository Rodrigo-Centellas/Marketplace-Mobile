import 'package:http/http.dart' as http;
import '../const/API_URL.dart';
class ApiService {
  // final String baseUrl = 'http://192.168.1.106:8001/api/auth';

   final String baseUrl = '${API_URL.apiUrl}/api/auth';

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
