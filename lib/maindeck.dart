import 'package:flutter/material.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/isardb.dart';
import 'package:membit/main.dart';

class Createdeck extends StatefulWidget {
  const Createdeck({super.key, required this.gohome});

  final Function() gohome;

  @override
  State<Createdeck> createState() => _CreatedeckState();
}

class _CreatedeckState extends State<Createdeck> {
  String? deckName;

  @override
  Widget build(BuildContext context) {
    final dbref = DbAccess.of(context).dbinstance;
    return Column(
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
        TextField(
          decoration: const InputDecoration(
            hintText: 'Deck Name',
          ),
          onSubmitted: (text) {
            print('$text');
            setState(() {
              deckName = text;
            });
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            ElevatedButton.icon(
              onPressed: () {
                print(deckName);
                Deck newdeck = Deck();
                newdeck.name = deckName.toString();
                dbref.saveDeck(newdeck);
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
                print("deletion!");
                widget.gohome();
              },
              icon: const Icon(Icons.cancel),
              label: const Text("Cancel"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            )
          ],
        )
      ],
    );
  }
}

class Maindeck extends StatefulWidget {
  const Maindeck({super.key});
  @override
  State<Maindeck> createState() => _MaindeckState();
}

class _MaindeckState extends State<Maindeck> {
  var selectedIndex = 0;

  void returnHome() {
    setState(() {
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    var pages = <Widget>[
      Padding(child: const Text("hello"), padding: EdgeInsets.all(8.0)),
      Createdeck(
        gohome: returnHome,
      )
    ];

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  print("Add button pressed");
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                icon: const Icon(Icons.add)),
            actions: [
              IconButton(
                  onPressed: () {
                    print("Delete button pressed");
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  icon: const Icon(Icons.delete)),
            ],
            title: const Center(
              child: Text(
                'Decks',
              ),
            )),
        body: pages[selectedIndex]);
  }
}
