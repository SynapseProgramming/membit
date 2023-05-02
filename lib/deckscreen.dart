import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/isardb.dart';
import 'package:membit/main.dart';
import 'package:membit/router.gr.dart';

@RoutePage()
class CreatedeckScreen extends StatefulWidget {
  const CreatedeckScreen({super.key});

  @override
  State<CreatedeckScreen> createState() => _CreatedeckScreenState();
}

class _CreatedeckScreenState extends State<CreatedeckScreen> {
  String? deckName;

  @override
  Widget build(BuildContext context) {
    final dbref = DbAccess.of(context).dbinstance;
    var router = context.router;
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
                router.pushNamed("list");
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

@RoutePage()
class DeckListScreen extends StatelessWidget {
  const DeckListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        child: const Text("hello"), padding: EdgeInsets.all(8.0));
  }
}

@RoutePage()
class DeckScreen extends StatefulWidget {
  const DeckScreen({super.key});
  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  var selectedIndex = 0;

  void returnHome() {
    setState(() {
      selectedIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var router = context.router;
    var pages = <Widget>[
      Padding(child: const Text("hello"), padding: EdgeInsets.all(8.0)),
      CreatedeckScreen()
    ];

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  print("Add button pressed");
                  router.push(const CreatedeckRoute());
                  // setState(() {
                  //   selectedIndex = 1;
                  // });
                },
                icon: const Icon(Icons.add)),
            actions: [
              IconButton(
                  onPressed: () {
                    print("Delete button pressed");
                    // setState(() {
                    //   selectedIndex = 0;
                    // });
                  },
                  icon: const Icon(Icons.delete)),
            ],
            title: const Center(
              child: Text(
                'Decks',
              ),
            )),
        // body: pages[selectedIndex]);
        body: AutoRouter());
  }
}
