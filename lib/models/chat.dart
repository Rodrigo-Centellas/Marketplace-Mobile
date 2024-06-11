// class Chat {
//   final int anuncioId;
//   final String anuncioTitle;
//   final double anuncioPrice;
//   final int sellerId;
//   final String sellerName;
//   final int buyerId;
//   final String lastMessage;
//   final bool hasNewMessages;

//   Chat({
//     required this.anuncioId,
//     required this.anuncioTitle,
//     required this.anuncioPrice,
//     required this.sellerId,
//     required this.sellerName,
//     required this.buyerId,
//     required this.lastMessage,
//     required this.hasNewMessages,
//   });

//   factory Chat.fromJson(Map<String, dynamic> json) {
//     return Chat(
//       anuncioId: json['anuncio_id'],
//       anuncioTitle: json['anuncio_title'],
//       anuncioPrice: json['anuncio_price'].toDouble(),
//       sellerId: json['seller_id'],
//       sellerName: json['seller_name'],
//       buyerId: json['buyer_id'],
//       lastMessage: json['last_message'],
//       hasNewMessages: json['has_new_messages'],
//     );
//   }
// }


class Chat {
  final int anuncioId;
  final String anuncioTitle;
  final double anuncioPrice;
  final int sellerId;
  final String sellerName;
  final int buyerId;
  final String lastMessage;
  final bool hasNewMessages;

  Chat({
    required this.anuncioId,
    required this.anuncioTitle,
    required this.anuncioPrice,
    required this.sellerId,
    required this.sellerName,
    required this.buyerId,
    required this.lastMessage,
    required this.hasNewMessages,
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      anuncioId: json['anuncio_id'],
      anuncioTitle: json['anuncio_title'],
      anuncioPrice: json['anuncio_price'].toDouble(),
      sellerId: json['seller_id'],
      sellerName: json['seller_name'],
      buyerId: json['buyer_id'],
      lastMessage: json['last_message'],
      hasNewMessages: json['has_new_messages'],
    );
  }
}
