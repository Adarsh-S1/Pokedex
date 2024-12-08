import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChatBot extends StatefulWidget {
  const ChatBot({super.key});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  final ChatUser _chatUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
      id: "1", firstName: "Gemini", profileImage: "assets/poke_title.png");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Image.asset(
            "assets/poke_title.png",
            width: 180,
            height: 100,
          ),
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return DashChat(
        currentUser: _chatUser, onSend: sendMessage, messages: messages);
  }

  void sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String Question = chatMessage.text;
      gemini.streamGenerateContent(Question).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
              user: geminiUser, createdAt: DateTime.now(), text: response);
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } on GeminiException catch (e) {
      if (e.statusCode == 403) {
        // Show user-friendly error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Access denied: ${e.message}")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $e")),
        );
      }
    }
  }
}
