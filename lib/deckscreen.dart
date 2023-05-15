import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/entities/card.dart' as deckcard;
import 'package:membit/isardb.dart';
import 'package:membit/main.dart';
import 'package:membit/router.gr.dart';

@RoutePage()
class DeleteDeckScreen extends StatefulWidget {
  const DeleteDeckScreen({super.key});

  @override
  State<DeleteDeckScreen> createState() => _DeleteDeckScreenState();
}

class _DeleteDeckScreenState extends State<DeleteDeckScreen> {
  List<DataColumn> _columns() {
    return [
      const DataColumn(label: Text('Deck')),
    ];
  }

  List<DataRow> rows = [
    const DataRow(cells: [DataCell(Text("no"))])
  ];

  Future<void> getRows(IsarDb db) async {
    List<Deck> decks = await db.getAllDecks();
    setState(() {
      rows.clear();
      rows = decks.map((e) {
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
            cells: [DataCell(Text(e.name))]);
      }).toList();
    });
  }

  Map<int, bool> ticked = {};

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
        title: Center(child: Text("Delete Decks")),
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
                  Deck? deckref = await dbref.getDeckById(id);
                  Deck notnulldeckref = deckref!;
                  List<deckcard.Card> deckcards =
                      await dbref.getCardsFor(notnulldeckref);
                  List<int> cardids = deckcards.map((e) => e.id).toList();
                  dbref.deleteCards(cardids);
                }
              }
              // delete all cards belong to that deck

              dbref.deleteDecks(todelete);
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
      ),
    );
  }
}

@RoutePage()
class CreatedeckScreen extends StatefulWidget {
  const CreatedeckScreen({super.key});

  @override
  State<CreatedeckScreen> createState() => _CreatedeckScreenState();
}

class _CreatedeckScreenState extends State<CreatedeckScreen> {
  String? deckName;
  var snack = const SnackBar(content: Text("Saved Deck!"));
  final GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final dbref = DbAccess.of(context).dbinstance;
    var router = context.router;
    return Form(
      key: _formkey,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Add Deck',
            style: TextStyle(
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
              decoration: const InputDecoration(
                  hintText: 'Deck Name',
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red))),
              onChanged: (text) {
                deckName = text;
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
                onPressed: () {
                  bool valid = _formkey.currentState!.validate();
                  if (valid) {
                    Deck newdeck = Deck();
                    newdeck.name = deckName.toString();
                    dbref.saveDeck(newdeck);
                    ScaffoldMessenger.of(context).showSnackBar(snack);
                  }
                },
                icon: const Icon(Icons.check),
                label: const Text("Add"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              ),
              const SizedBox(
                width: 30,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  router.navigateNamed('list');
                },
                icon: const Icon(Icons.cancel),
                label: const Text("Cancel"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              )
            ],
          )
        ],
      ),
    );
  }
}

@RoutePage()
class DeckRouterScreen extends StatelessWidget {
  const DeckRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage()
class DeckListScreen extends StatelessWidget {
  const DeckListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dbref = DbAccess.of(context).dbinstance;
    final router = context.router.parent<StackRouter>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<List<Deck>>(
        stream: dbref.listenDecks(),
        builder: (context, snapshot) => GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          scrollDirection: Axis.vertical,
          children: snapshot.hasData
              ? snapshot.data!.map((course) {
                  return ElevatedButton(
                    onPressed: () {
                      router?.navigate(DeckMenuRoute(DeckName: course.name));
                    },
                    child: Text(course.name),
                  );
                }).toList()
              : [],
        ),
      ),
    );
  }
}

@RoutePage()
class DeckScreen extends StatelessWidget {
  const DeckScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var router = context.router;
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  router.navigateNamed("create");
                },
                icon: const Icon(Icons.add)),
            actions: [
              IconButton(
                  onPressed: () {
                    router.navigate(DeleteDeckRoute());
                  },
                  icon: const Icon(Icons.delete)),
            ],
            title: const Center(
              child: Text(
                'Decks',
              ),
            )),
        body: const AutoRouter());
  }
}
