import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/openai.dart';
import 'package:membit/cardjson.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/env.dart';

import 'package:membit/entities/card.dart' as deckcard;
import 'dart:convert';

import 'package:membit/main.dart';

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
    final dbref = DbAccess.of(context).dbinstance;

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
                      String request = "Generate ";
                      request += selectedcards.toString();
                      request += " flashcards about ";
                      request += DescName;
                      request +=
                          ",in the following json format. {\"flashcards': [{\"front\": \"hello\", \"back\": \"world\"},]}  Only return the json string. The front of the card should be ";
                      request += FrontName;
                      request += ", the back of the card should be ";
                      request += BackName;
                      print(request);
                      String response = await completeChat(request);
                      print(response);
                      // TODO: add exception handling for parsed Json
                      final parsedJson = jsonDecode(response);
                      FlashCardsJson obj = FlashCardsJson.fromJson(parsedJson);
                      List<CardJson> test = obj.cards;

                      Deck? deckRef = await dbref.getDeck(widget.DeckName);
                      Deck notnullref = deckRef!;
                      List<deckcard.Card> cards = test.map((e) {
                        deckcard.Card newcard = deckcard.Card()
                          ..front = e.front
                          ..back = e.back
                          ..difficulty = 1
                          ..deck.value = notnullref;
                        return newcard;
                      }).toList();
                      for (var card in cards) {
                        await dbref.saveCard(card);
                      }

                      for (var x in test) {
                        print(x.front);
                        print(x.back);
                      }

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
