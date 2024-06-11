import 'package:flutter/material.dart';
import 'package:shop_app/models/chat.dart';
import 'package:shop_app/screens/messages/message_service.dart';
import 'package:shop_app/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';


class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static String routeName = "/chats";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Index de chats"),
      ),
      body: FutureBuilder<List<Chat>>(
        future: MessageService().getUserChats(), // Usar MessageService para obtener los chats del usuario
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Mostrar detalles del error
            return Center(child: Text("Error al cargar los chats: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No tienes conversaciones aún"));
          } else {
            final chats = snapshot.data!;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  leading: const Icon(Icons.chat_bubble_outline),
                  title: Text(chat.anuncioTitle),
                  subtitle: Text(chat.lastMessage),
                  trailing: chat.hasNewMessages
                      ? const Icon(Icons.circle, color: Colors.red, size: 10)
                      : null,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      MessageScreen.routeName,
                      arguments: MessageScreenArguments(
                        title: chat.anuncioTitle,
                        price: chat.anuncioPrice.toString(),
                        seller: chat.sellerName,
                        sellerId: chat.sellerId,
                        buyerId: chat.buyerId,
                        anuncioId: chat.anuncioId,
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
