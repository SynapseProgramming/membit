import 'package:flutter/material.dart';

class Maindeck extends StatefulWidget {
  @override
  State<Maindeck> createState() => _MaindeckState();
}

class _MaindeckState extends State<Maindeck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  print("Add button pressed");
                },
                icon: Icon(Icons.add)),
            actions: [
              IconButton(
                  onPressed: () {
                    print("Delete button pressed");
                  },
                  icon: Icon(Icons.delete)),
            ],
            title: Center(
              child: const Text(
                'Decks',
              ),
            )),
        body:
            Padding(child: const Text("hello"), padding: EdgeInsets.all(8.0)));
  }
}
