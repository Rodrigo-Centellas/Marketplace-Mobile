import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/Categoria.dart';
import '../const/API_URL.dart';
class ApiService {
  // final String baseUrl = 'http://192.168.1.106:8001/api';
  final String baseUrl = '${API_URL.apiUrl}/api';
  Future<List<Categoria>> fetchCategorias() async {
    final response = await http.get(Uri.parse('$baseUrl/categorias'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((data) => Categoria.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}