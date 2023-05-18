import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/openai.dart';
import 'package:membit/env.dart';

@RoutePage()
class GptAddScreen extends StatefulWidget {
  GptAddScreen({super.key, required this.DeckName}) {
    OpenAI.apiKey = Env.key;
  }

  final String DeckName;

  @override
  State<GptAddScreen> createState() => _GptAddScreenState();
}

class _GptAddScreenState extends State<GptAddScreen> {
  Future<String> completeChat(String message) async {
    final chatCompletion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: [
        OpenAIChatCompletionChoiceMessageModel(
          content: message,
          role: OpenAIChatMessageRole.user,
        ),
      ],
    );
    return chatCompletion.choices.first.message.content;
  }

  @override
  Widget build(BuildContext context) {
    var router = context.router;
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                router.pop();
              },
              child: Text(widget.DeckName)),
          ElevatedButton(
              onPressed: () async {
                String response = await completeChat(
                    "Generate 10 flashcards about japanese words describing items which can be found in a school, in the following json format. Only return the json string. The front of the card should be the kanji characters, the back of the card should be the romanji of the character {'flashcards': [{'front': 'hello', 'back': 'world'},]}");
                print(response);
              },
              child: Text("send query"))
        ],
      ),
    );
  }
}
