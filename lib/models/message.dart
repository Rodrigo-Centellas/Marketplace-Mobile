// class Message {
//   final int id;
//   final String content;
//   final int userId;
//   final int anuncioId;
//   final DateTime createdAt;

//   Message({
//     required this.id,
//     required this.content,
//     required this.userId,
//     required this.anuncioId,
//     required this.createdAt,
//   });

//   factory Message.fromJson(Map<String, dynamic> json) {
//     return Message(
//       id: json['id'],
//       content: json['content'],
//       userId: json['user_id'],
//       anuncioId: json['anuncio_id'],
//       createdAt: DateTime.parse(json['created_at']),
//     );
//   }
// }



class Message {
  final int id;
  final String content;
  final int userId;
  final int anuncioId;
  final DateTime createdAt;

  Message({
    required this.id,
    required this.content,
    required this.userId,
    required this.anuncioId,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['contenido'],
      userId: json['user1_id'],
      anuncioId: json['anuncio_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
