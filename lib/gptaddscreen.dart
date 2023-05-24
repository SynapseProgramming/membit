import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:dart_openai/openai.dart';
import 'package:membit/cardjson.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/env.dart';

import 'package:membit/entities/card.dart' as deckcard;
import 'package:membit/isardb.dart';
import 'dart:convert';

import 'package:membit/main.dart';
import 'package:membit/router.gr.dart';

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
    // TODO: catch any exceptions here (request failed exception)
    try {
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
    } catch (e) {
      return Future.value("error");
    }
  }

  final frontTextController = TextEditingController();
  final backTextController = TextEditingController();
  final descTextController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey();

  late String FrontName;
  late String BackName;
  late String DescName;

  List<int> cardno = [5, 10, 15, 20];
  int selectedcards = 5;

  void gptwarning() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('GPT Error'),
        content: const Text(
            'GPT failed to return a valid response. Keep current inputs ?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Yes'),
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              frontTextController.clear();
              descTextController.clear();
              backTextController.clear();
              Navigator.pop(context, 'No');
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

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
                      try {
                        final parsedJson = jsonDecode(response);
                        FlashCardsJson obj =
                            FlashCardsJson.fromJson(parsedJson);
                        List<CardJson> jsoncards = obj.cards;

                        Deck? deckRef = await dbref.getDeck(widget.DeckName);
                        Deck notnullref = deckRef!;
                        List<deckcard.Card> cards = jsoncards
                            .map((e) => deckcard.Card()
                              ..front = e.front
                              ..back = e.back
                              ..difficulty = 1
                              ..deck.value = notnullref)
                            .toList();

                        frontTextController.clear();
                        descTextController.clear();
                        backTextController.clear();
                        router.navigate(GeneratedCardRoute(
                            cards: cards, DeckName: widget.DeckName));
                      } catch (e) {
                        gptwarning();
                      }
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Create"))
            ]),
          ),
        ));
  }
}

@RoutePage()
class GeneratedCardScreen extends StatefulWidget {
  const GeneratedCardScreen(
      {super.key, required this.cards, required this.DeckName});

  final List<deckcard.Card> cards;
  final String DeckName;

  @override
  State<GeneratedCardScreen> createState() => _GeneratedCardScreenState();
}

class _GeneratedCardScreenState extends State<GeneratedCardScreen> {
  List<DataColumn> _columns() {
    return [
      const DataColumn(label: Text('Front')),
      const DataColumn(label: Text('Back'))
    ];
  }

  List<DataRow> rows = [
    const DataRow(cells: [DataCell(Text("no")), DataCell(Text("data"))])
  ];

  void getRows() {
    setState(() {
      rows.clear();
      rows = widget.cards
          .map((e) =>
              DataRow(cells: [DataCell(Text(e.front)), DataCell(Text(e.back))]))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var router = context.router;
    final dbref = DbAccess.of(context).dbinstance;
    getRows();
    return Scaffold(
      appBar: AppBar(
          title: Center(
        child: Text("Generated Cards"),
      )),
      body: Center(
          child: Column(
        children: [
          Container(
            height: 450,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(columns: _columns(), rows: rows)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  for (var card in widget.cards) {
                    await dbref.saveCard(card);
                  }
                  router.popUntilRouteWithPath("deckmenu");
                },
                icon: const Icon(Icons.check),
                label: const Text("Add"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              SizedBox(
                width: 30,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  router.pop();
                },
                icon: const Icon(Icons.cancel),
                label: const Text("Cancel"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              )
            ],
          )
        ],
      )),
    );
  }
}
