import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/router.gr.dart';

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
              IconButton(
                  onPressed: () {
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
              Text(DeckName, style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
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
                  // Action to perform when button is pressed
                  print("Add cards pressed");
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
