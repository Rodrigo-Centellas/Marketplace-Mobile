import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/membrecia.dart'; // Asegúrate de importar el modelo correcto
import '../const/API_URL.dart';

class ApiService {
  static const String baseUrl = '${API_URL.apiUrl}/api';

  Future<List<Membresia>> fetchMembresias() async {
    final response = await http.get(Uri.parse('$baseUrl/membrecias'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Membresia.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener membrecias');
    }
  }
  
}
