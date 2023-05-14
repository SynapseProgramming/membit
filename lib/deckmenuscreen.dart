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

  List<DataRow> rows = [
    const DataRow(cells: [DataCell(Text("no")), DataCell(Text("data"))])
  ];

  Map<int, bool> ticked = {};

  Future<void> getRows(IsarDb db) async {
    Deck? nulldeck = await db.getDeck(widget.DeckName);
    Deck deck = nulldeck!;
    List<deckcard.Card> cards = await db.getCardsFor(deck);
    setState(() {
      rows.clear();
      rows = cards.map((e) {
        if (ticked[e.id] == null) {
          ticked[e.id] = false;
        }

        return DataRow(
            selected: ticked[e.id]!,
            onSelectChanged: (bool? selected) {
              setState(() {
                ticked[e.id] = selected!;
              });
            },
            cells: [DataCell(Text(e.front)), DataCell(Text(e.back))]);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    var router = context.router;
    final dbref = DbAccess.of(context).dbinstance;
    getRows(dbref);

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
              onPressed: () {
                List<int> todelete = [];
                for (var entry in ticked.entries) {
                  int id = entry.key;
                  bool status = entry.value;
                  if(status==true){todelete.add(id);}
                }
                dbref.deleteCards(todelete);
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
                    child: DataTable(columns: _columns(), rows: rows)),
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

    return SafeArea(
      child: Form(
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
                    print("kek");
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
      const DataColumn(label: Text('Back'))
    ];
  }

  List<DataRow> rows = [
    const DataRow(cells: [DataCell(Text("no")), DataCell(Text("data"))])
  ];

  Future<void> getRows(IsarDb db) async {
    Deck? nulldeck = await db.getDeck(widget.DeckName);
    Deck deck = nulldeck!;
    List<deckcard.Card> cards = await db.getCardsFor(deck);
    setState(() {
      rows.clear();
      rows = cards
          .map((e) =>
              DataRow(cells: [DataCell(Text(e.front)), DataCell(Text(e.back))]))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final dbref = DbAccess.of(context).dbinstance;

    getRows(dbref);

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
              ElevatedButton(
                onPressed: () {
                  // Action to perform when button is pressed
                  print("start pressed");
                },
                child: Text('Start'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.green),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print("Add cards pressed");
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
              Container(
                height: 450,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(columns: _columns(), rows: rows)),
              )
            ],
          ),
        ));
  }
}
