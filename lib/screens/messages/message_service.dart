// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shop_app/models/chat.dart';
// import 'package:shop_app/models/Message.dart';
// import 'package:shop_app/Api/token_storage_service.dart';

// class MessageService {
//   final String apiUrl = 'http://192.168.1.106:8001/api/auth/chats'; // Cambia esto por tu URL de la API real

//   Future<List<Chat>> getUserChats() async {
//     final authToken = await TokenStorageService.getToken();
//     final response = await http.get(
//       Uri.parse(apiUrl),
//       headers: {
//         'Authorization': 'Bearer $authToken',
//       },
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Chat.fromJson(json)).toList();
//     } else {
//       // Añadir detalles adicionales del error
//       final errorDetails = json.decode(response.body);
//       throw Exception('Failed to load chats: ${response.statusCode} ${response.reasonPhrase} ${errorDetails}');
//     }
//   }

//   Future<List<Message>> getMessages(int anuncioId) async {
//     final authToken = await TokenStorageService.getToken();
//     final response = await http.get(
//       Uri.parse('$apiUrl/$anuncioId/messages'),
//       headers: {
//         'Authorization': 'Bearer $authToken',
//       },
//     );

//     if (response.statusCode == 200) {
//       final List<dynamic> data = json.decode(response.body);
//       return data.map((json) => Message.fromJson(json)).toList();
//     } else {
//       // Añadir detalles adicionales del error
//       final errorDetails = json.decode(response.body);
//       throw Exception('Failed to load messages: ${response.statusCode} ${response.reasonPhrase} ${errorDetails}');
//     }
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/chat.dart';
import 'package:shop_app/models/Message.dart';
import 'package:shop_app/Api/token_storage_service.dart';

class MessageService {
  final String apiUrl = 'http://192.168.1.106:8001/api';

  Future<String?> getAuthToken() async {
    return await TokenStorageService.getToken();
  }

  Future<List<Chat>> getUserChats() async {
    final authToken = await getAuthToken();
    final response = await http.get(
      Uri.parse('$apiUrl/auth/chats'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Chat.fromJson(json)).toList();
    } else {
      final errorDetails = json.decode(response.body);
      throw Exception('Failed to load chats: ${response.statusCode} ${response.reasonPhrase} ${errorDetails}');
    }
  }

  Future<List<Message>> getMessages(int user1Id, int user2Id, int anuncioId) async {
    final authToken = await getAuthToken();
    final response = await http.get(
      Uri.parse('$apiUrl/auth/mensajes?user1_id=$user1Id&user2_id=$user2Id&anuncio_id=$anuncioId'),
      headers: {
        'Authorization': 'Bearer $authToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Message.fromJson(json)).toList();
    } else {
      final errorDetails = json.decode(response.body);
      throw Exception('Failed to load messages: ${response.statusCode} ${response.reasonPhrase} ${errorDetails}');
    }
  }

  Future<Message> createMessage(String content, int user2Id, int anuncioId) async {
    final authToken = await getAuthToken();
    final response = await http.post(
      Uri.parse('$apiUrl/auth/mensajes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(<String, dynamic>{
        'contenido': content,
        'user2_id': user2Id,
        'anuncio_id': anuncioId,
      }),
    );

    if (response.statusCode == 201) {
      return Message.fromJson(json.decode(response.body));
    } else {
      final errorDetails = json.decode(response.body);
      throw Exception('Failed to create message: ${response.statusCode} ${response.reasonPhrase} ${errorDetails}');
    }
  }
}
