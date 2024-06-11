import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/models/Message.dart';
import 'package:shop_app/screens/messages/message_service.dart';

class MessageScreenArguments {
  final String title;
  final String price;
  final String seller;
  final int sellerId;
  final int buyerId;
  final int anuncioId;

  MessageScreenArguments({
    required this.title,
    required this.price,
    required this.seller,
    required this.sellerId,
    required this.buyerId,
    required this.anuncioId,
  });
}

class MessageScreen extends StatefulWidget {
  static String routeName = "/messages";

  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late Future<List<Message>> futureMessages;
  late MessageScreenArguments args;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as MessageScreenArguments;
    futureMessages = MessageService().getMessages(args.buyerId, args.sellerId, args.anuncioId);
  }

  void refreshMessages() {
    setState(() {
      futureMessages = MessageService().getMessages(args.buyerId, args.sellerId, args.anuncioId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(args.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 4),
            Row(
              children: [
                Text('\$${args.price}', style: TextStyle(fontSize: 14, color: Colors.white70)),
                SizedBox(width: 8),
                Icon(Icons.person, size: 16, color: Colors.white70),
                SizedBox(width: 4),
                Text(args.seller, style: TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ],
        ),
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Message>>(
                future: futureMessages,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error al cargar los mensajes: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("No hay mensajes en esta conversación"));
                  } else {
                    final messages = snapshot.data!;
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMe = message.userId == args.buyerId; 
                        return MessageBubble(
                          isMe: isMe,
                          message: message.content,
                        );
                      },
                    );
                  }
                },
              ),
            ),
            MessageInputField(anuncioId: args.anuncioId, sellerId: args.sellerId, onSend: refreshMessages),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final bool isMe;
  final String message;

  const MessageBubble({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.orange : Colors.blue,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Text(
            message,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class MessageInputField extends StatefulWidget {
  final int anuncioId;
  final int sellerId;
  final VoidCallback onSend;

  const MessageInputField({Key? key, required this.anuncioId, required this.sellerId, required this.onSend}) : super(key: key);

  @override
  _MessageInputFieldState createState() => _MessageInputFieldState();
}

class _MessageInputFieldState extends State<MessageInputField> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      try {
        await MessageService().createMessage(
          _controller.text,
          widget.sellerId,
          widget.anuncioId,
        );
        _controller.clear();
        widget.onSend();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to send message: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, -3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: kPrimaryColor),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
