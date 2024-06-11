import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/Message.dart';
import 'package:shop_app/Api/token_storage_service.dart';

class MessageService {
  final String apiUrl = 'http://192.168.1.106:8001/api/mensajes';

  Future<List<Message>> getMessages(int user1Id, int user2Id, int anuncioId) async {
    final authToken = await TokenStorageService.getToken();
    final response = await http.get(
      Uri.parse('$apiUrl?user1_id=$user1Id&user2_id=$user2Id&anuncio_id=$anuncioId'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<Message> createMessage(String content, int user2Id, int anuncioId) async {
    final authToken = await TokenStorageService.getToken();
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'contenido': content,
        'user2_id': user2Id,
        'anuncio_id': anuncioId,
      }),
    );

    if (response.statusCode == 201) {
      return Message.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create message');
    }
  }
}
