import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:isar/isar.dart';
import 'package:membit/isardb.dart';
import 'package:membit/main.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/entities/card.dart' as deckcard;
import 'package:membit/router.gr.dart';

@RoutePage()
class DeleteCardScreen extends StatefulWidget {
  DeleteCardScreen({super.key, required this.DeckName});

  final String DeckName;

  @override
  State<DeleteCardScreen> createState() => _DeleteCardScreenState();
}

class _DeleteCardScreenState extends State<DeleteCardScreen> {
  List<DataColumn> _columns() {
    return [
      const DataColumn(label: Text('Front')),
      const DataColumn(label: Text('Back'))
    ];
  }

  List<deckcard.Card> cards = [];
  bool firedbefore = false;

  Map<int, bool> ticked = {};

  Future<void> getCards(IsarDb db) async {
    if (firedbefore == false) {
      Deck? nulldeck = await db.getDeck(widget.DeckName);
      Deck deck = nulldeck!;
      cards = await db.getCardsFor(deck);
      setState(() {
        firedbefore = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var router = context.router;
    final dbref = DbAccess.of(context).dbinstance;
    getCards(dbref);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          leading: IconButton(
              onPressed: () {
                router.pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: Center(child: Text("Delete Cards")),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                List<int> todelete = [];
                for (var entry in ticked.entries) {
                  int id = entry.key;
                  bool status = entry.value;
                  if (status == true) {
                    todelete.add(id);
                  }
                }
                await dbref.deleteCards(todelete);
                setState(() {
                  firedbefore = false;
                });
              },
              child: Text('Delete'),
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.red),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 550,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                        columns: _columns(),
                        rows: List.generate(cards.length, (index) {
                          if (ticked[cards[index].id] == null) {
                            ticked[cards[index].id] = false;
                          }

                          return DataRow(
                              selected: ticked[cards[index].id]!,
                              onSelectChanged: (bool? selected) {
                                setState(() {
                                  ticked[cards[index].id] = selected!;
                                });
                              },
                              cells: [
                                DataCell(Text(cards[index].front)),
                                DataCell(Text(cards[index].back))
                              ]);
                        }))),
              ),
            ),
          ],
        ));
  }
}

@RoutePage()
class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key, required this.DeckName});

  final String DeckName;

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  late String FrontName;
  late String BackName;
  var snack = const SnackBar(content: Text("Saved Card!"));

  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final dbref = DbAccess.of(context).dbinstance;
    String title = 'Add cards to ' + widget.DeckName;

    var router = context.router;
    final frontTextController = TextEditingController();
    final backTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Add Cards"),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
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
                    hintText: 'Front',
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
                    hintText: 'Back',
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
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    bool valid = _formkey.currentState!.validate();
                    if (valid) {
                      Deck? deckRef = await dbref.getDeck(widget.DeckName);
                      Deck notnullref = deckRef!;

                      final newCard = deckcard.Card()
                        ..front = FrontName
                        ..back = BackName
                        ..difficulty = 1
                        ..deck.value = notnullref;

                      await dbref.saveCard(newCard);
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                      frontTextController.clear();
                      backTextController.clear();
                    }
                  },
                  icon: const Icon(Icons.check),
                  label: const Text("Add"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                ),
                const SizedBox(
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
        ),
      ),
    );
  }
}

@RoutePage()
class EditCardScreen extends StatefulWidget {
  const EditCardScreen({super.key, required this.card});
  final deckcard.Card card;

  @override
  State<EditCardScreen> createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();

  late String FrontName = widget.card.front;
  late String BackName = widget.card.back;

  @override
  Widget build(BuildContext context) {
    final frontTextController = TextEditingController(text: widget.card.front);
    final backTextController = TextEditingController(text: widget.card.back);
    final dbref = DbAccess.of(context).dbinstance;
    var router = context.router;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(
          child: Text('Edit Card'),
        ),
      ),
      body: Center(
          child: Form(
        key: _formkey,
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          Text("Front Card"),
          Container(
            width: 350,
            child: TextFormField(
              controller: frontTextController,
              decoration: const InputDecoration(
                  hintText: "New Front",
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
          Text("Back Card"),
          Container(
            width: 350,
            child: TextFormField(
              controller: backTextController,
              decoration: const InputDecoration(
                  hintText: "New Back",
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
          ElevatedButton.icon(
            onPressed: () async {
              bool valid = _formkey.currentState!.validate();
              if (valid) {
                // update given card
                deckcard.Card current = widget.card;
                current.front = FrontName;
                current.back = BackName;
                await dbref.saveCard(current);
                router.pop();
              }
            },
            icon: const Icon(Icons.check),
            label: const Text("Save Changes"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          ),
          const SizedBox(
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
        ]),
      )),
    );
  }
}

@RoutePage()
class DeckMenuScreen extends StatefulWidget {
  DeckMenuScreen({super.key, required this.DeckName});

  final String DeckName;

  @override
  State<DeckMenuScreen> createState() => _DeckMenuScreenState();
}

class _DeckMenuScreenState extends State<DeckMenuScreen> {
  List<DataColumn> _columns() {
    return [
      const DataColumn(label: Text('Front')),
      const DataColumn(label: Text('Back')),
      const DataColumn(label: Text('Edit'))
    ];
  }

  List<DataRow> rows = [
    DataRow(cells: [
      DataCell(Text("no")),
      DataCell(Text("data")),
      DataCell(IconButton(
        icon: Icon(Icons.edit),
        onPressed: () => null,
      ))
    ])
  ];

  Future<void> getRows(IsarDb db, StackRouter router) async {
    Deck? nulldeck = await db.getDeck(widget.DeckName);
    Deck deck = nulldeck!;
    List<deckcard.Card> cards = await db.getCardsFor(deck);
    setState(() {
      rows.clear();
      rows = cards
          .map((e) => DataRow(cells: [
                DataCell(Text(e.front)),
                DataCell(Text(e.back)),
                DataCell(IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    router.navigate(EditCardRoute(card: e));
                  },
                ))
              ]))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final dbref = DbAccess.of(context).dbinstance;

    getRows(dbref, router);

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            leading: IconButton(
                onPressed: () {
                  router.pop();
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                  onPressed: () {
                    router.navigate(DeleteCardRoute(DeckName: widget.DeckName));
                  },
                  icon: const Icon(Icons.delete)),
            ],
            title: Center(
              child: Text(
                'Deck',
              ),
            )),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text(widget.DeckName,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      // navigate to card show
                      Deck? currdeck = await dbref.getDeck(widget.DeckName);
                      Deck notnulldeck = currdeck!;

                      router.navigate(CardShowRoute(currentDeck: notnulldeck));
                    },
                    child: Text('Start'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.green),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Flip Cards'),
                          content: const Text(
                              'Do you wish to flip the front and back cards?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () async {
                                Deck? nulldeck =
                                    await dbref.getDeck(widget.DeckName);
                                Deck deck = nulldeck!;
                                List<deckcard.Card> cards =
                                    await dbref.getCardsFor(deck);
                                for (deckcard.Card cd in cards) {
                                  String temp = cd.front;
                                  cd.front = cd.back;
                                  cd.back = temp;
                                  await dbref.saveCard(cd);
                                }
                                Navigator.pop(context, 'Yes');
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context, 'No');
                              },
                              child: const Text('No'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text('Flip Cards'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.pink),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      router.navigate(AddCardRoute(DeckName: widget.DeckName));
                    },
                    child: Text('Add Cards'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      router.navigate(GptAddRoute(DeckName: widget.DeckName));
                    },
                    child: Text('GPT Add'),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(150, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.purple),
                  )
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(columns: _columns(), rows: rows)),
              )
            ],
          ),
        ));
  }
}
