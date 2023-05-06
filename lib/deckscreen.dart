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
  var snack = const SnackBar(content: Text("Saved Deck!"));


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
          onChanged: (text) {
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
                Deck newdeck = Deck();
                newdeck.name = deckName.toString();
                dbref.saveDeck(newdeck);
                ScaffoldMessenger.of(context).showSnackBar(snack);
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
