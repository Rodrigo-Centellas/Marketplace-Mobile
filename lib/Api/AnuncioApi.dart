//Aoi de anuncio 
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/anuncio.dart';

class ApiService {
  static const String baseUrl  = 'http://192.168.1.106:8001/api';
  // static const String baseUrl  = 'https://jose-test.site/api';


  Future<List<Anuncio>> fetchAnuncios() async {
    final response = await http.get(Uri.parse('$baseUrl/anuncios'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Anuncio.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener los anuncios');
    }
  }
}