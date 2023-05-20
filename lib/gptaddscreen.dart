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

  // "Generate 10 flashcards about japanese words describing items which can be found in a school, in the following json format. Only return the json string. The front of the card should be the kanji characters, the back of the card should be the romanji of the character {'flashcards': [{'front': 'hello', 'back': 'world'},]}");

  final frontTextController = TextEditingController();
  final backTextController = TextEditingController();
  final descTextController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  late String FrontName;
  late String BackName;
  late String DescName;

  List<int> cardno = [5, 10, 15, 20];
  int selectedcards = 5;

  @override
  Widget build(BuildContext context) {
    var router = context.router;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
                onPressed: () {
                  router.pop();
                },
                icon: const Icon(Icons.arrow_back)),
            title: Center(
              child: Text(
                'GPTCards',
              ),
            )),
        body: Center(
          child: Form(
            key: _formkey,
            child: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                child: TextFormField(
                  controller: descTextController,
                  decoration: const InputDecoration(
                      hintText: 'Description of Cards',
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                  onChanged: (text) {
                    DescName = text;
                  },
                  validator: (value) {
                    if (value != null && value.isEmpty)
                      return "please enter some text";
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                child: TextFormField(
                  controller: frontTextController,
                  decoration: const InputDecoration(
                      hintText: 'Front Card Description',
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                  onChanged: (text) {
                    FrontName = text;
                  },
                  validator: (value) {
                    if (value != null && value.isEmpty)
                      return "please enter some text";
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 350,
                child: TextFormField(
                  controller: backTextController,
                  decoration: const InputDecoration(
                      hintText: 'Back Card Description',
                      border: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                  onChanged: (text) {
                    BackName = text;
                  },
                  validator: (value) {
                    if (value != null && value.isEmpty)
                      return "please enter some text";
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 40,
                  ),
                  Text("Number of cards"),
                  SizedBox(
                    width: 20,
                  ),
                  DropdownButton<int>(
                      value: selectedcards,
                      onChanged: (value) {
                        setState(
                          () {
                            selectedcards = value!;
                          },
                        );
                      },
                      items: cardno.map<DropdownMenuItem<int>>((e) {
                        return DropdownMenuItem<int>(
                            value: e, child: Text(e.toString()));
                      }).toList()),
                ],
              ),
              ElevatedButton.icon(
                  onPressed: () async {
                    bool valid = _formkey.currentState!.validate();
                    if (valid) {
                      print(DescName);
                      print(FrontName);
                      print(BackName);
                      print(selectedcards);
                      frontTextController.clear();
                      descTextController.clear();
                      backTextController.clear();
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Create"))
            ]),
          ),
        ));
  }
}
