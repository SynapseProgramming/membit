import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/router.gr.dart';

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


  @override
  Widget build(BuildContext context) {
    String title = 'Add cards to ' + widget.DeckName;
    var router = context.router;
    return SafeArea(
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
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Front',
              ),
              onChanged: (text) {
                FrontName = text;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 350,
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Back',
              ),
              onChanged: (text) {
                BackName = text;
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
                  print(FrontName);
                  print(BackName);
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
    );
  }
}

@RoutePage()
class DeckMenuScreen extends StatelessWidget {
  const DeckMenuScreen({super.key, required this.DeckName});

  final String DeckName;

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            leading: IconButton(
                onPressed: () {
                  router.pop();
                },
                icon: const Icon(Icons.arrow_back)),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
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
              Text(DeckName,
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
                  router.navigate(AddCardRoute(DeckName: DeckName));
                },
                child: Text('Add Cards'),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.blue),
              ),
            ],
          ),
        ));
  }
}
