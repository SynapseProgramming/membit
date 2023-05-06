import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
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
            title: const Center(
              child: Text(
                'Card',
              ),
            )),
        body:  Padding(
          padding: const EdgeInsets.all(16),
          child: Text(DeckName),
        ));
  }
}
