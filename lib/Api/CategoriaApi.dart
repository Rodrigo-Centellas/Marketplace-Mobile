import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/Categoria.dart';

class ApiService {
  final String baseUrl = 'https://jose-test.site/api';

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