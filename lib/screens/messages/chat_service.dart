// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:shop_app/Api/token_storage_service.dart';

// class ChatService {
//   final String apiUrl = 'http://192.168.1.106:8001/api/auth/mensajes';

//   Future<String?> getAuthToken() async {
//     return await TokenStorageService.getToken();
//   }

//   Future<List<Message>> getMessages(int user1Id, int user2Id, int anuncioId) async {
//     final authToken = await getAuthToken();
//     final response = await http.get(
//       Uri.parse('$apiUrl?user1_id=$user1Id&user2_id=$user2Id&anuncio_id=$anuncioId'),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $authToken',
//       },
//     );

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((message) => Message.fromJson(message)).toList();
//     } else {
//       throw Exception('Failed to load messages');
//     }
//   }

//   Future<Message> createMessage(String contenido, int user2Id, int anuncioId) async {
//     final authToken = await getAuthToken();
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $authToken',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'contenido': contenido,
//         'user2_id': user2Id,
//         'anuncio_id': anuncioId,
//       }),
//     );

//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');

//     if (response.statusCode == 201) {
//       return Message.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failed to create message');
//     }
//   }
// }

// class Message {
//   final int id;
//   final String contenido;
//   final int user1Id;
//   final int user2Id;

//   Message({required this.id, required this.contenido, required this.user1Id, required this.user2Id});

//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       id: json['id'],
//       contenido: json['contenido'],
//       user1Id: json['user1_id'],
//       user2Id: json['user2_id'],
//     );
//   }
// }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app/Api/token_storage_service.dart';
import 'package:shop_app/models/chat.dart';
import '../../const/API_URL.dart';
import 'package:shop_app/models/Message.dart';

class ChatService {
  final String apiUrl = '${API_URL.apiUrl}/api/auth';
//  final String apiUrl = 'http://192.168.1.106:8001/api/auth';
  Future<String?> getAuthToken() async {
    return await TokenStorageService.getToken();
  }

  Future<List<Chat>> getUserChats() async {
    final authToken = await getAuthToken();
    final response = await http.get(
      Uri.parse('$apiUrl/chats'),
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

  Future<List<Message>> getMessages(int anuncioId) async {
    final authToken = await getAuthToken();
    final response = await http.get(
      Uri.parse('$apiUrl/mensajes?anuncio_id=$anuncioId'),
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

  Future<Message> createMessage(String contenido, int user2Id, int anuncioId) async {
    final authToken = await getAuthToken();
    final response = await http.post(
      Uri.parse('$apiUrl/mensajes'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(<String, dynamic>{
        'contenido': contenido,
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


