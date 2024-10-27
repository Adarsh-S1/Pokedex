import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';

// class MyLlm {
//   final _apiKey = "AIzaSyAlZVOPaTGqr7H31xsH238JWQbpRLxpJ8g";

//   // ignore: non_constant_identifier_names
//   Future<String> My_ai(String prompt) async {
//     final model = GenerativeModel(
//       model: 'gemini-1.5-flash-latest',
//       apiKey: _apiKey,
//     );

//     //const prompt = 'Write a story about a magic backpack.';
//     final content = [Content.text(prompt)];
//     final response = await model.generateContent(content);

//     return response.text!;
//   }
// }

class GroqClient {
  static const String baseUrl =
      "https://api.groq.com/openai/v1/chat/completions"; // Replace with your Groq API URL
  static const String apiKey =
      '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';

  get http => null; // Replace with your Groq API key

  Future<String> completeChat(String prompt) async {
    final url = Uri.parse('$baseUrl/chat/completions');
    final body = {
      'model': 'llama3-8b-8192',
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'temperature': 1,
      'max_tokens': 500,
      'top_p': 1,
      'stream': true,
      'stop': null,
    };

    final response = await http.post(url,
        body: jsonEncode(body), headers: {'Authorization': 'Bearer $apiKey'});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String completion = '';
      for (var item in data) {
        completion += item['choices'][0]['delta']['content'] ?? '';
      }
      return completion;
    } else {
      throw Exception('Failed to complete chat: ${response.statusCode}');
    }
  }
}

class MyLlm extends StatefulWidget {
  const MyLlm({super.key});

  @override
  State<MyLlm> createState() => _myLlmState();
}

// ignore: camel_case_types
class _myLlmState extends State<MyLlm> {
  final TextEditingController _messageController = TextEditingController();
  String _completion = '';

  Future<void> _completeChat(String prompt) async {
    try {
      final response = await GroqClient().completeChat(prompt);
      setState(() {
        _completion += response;
      });
      print(_completion);
    } on Exception catch (error) {
      print(error); // Handle errors appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Image.asset(
              "assets/poke_title.png",
              width: 180,
              height: 100,
            ),
          ),
          const Expanded(
            child: Text(
              "Coming Soon!!!!",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type your message...',
              ),
              onSubmitted: (text) {
                _completeChat(text);
                _messageController.clear();
              },
            ),
          ),
        ],
      ),
    );
  }
}
