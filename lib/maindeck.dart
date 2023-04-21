import 'package:flutter/material.dart';

class Createdeck extends StatefulWidget {
  const Createdeck({super.key});

  @override
  State<Createdeck> createState() => _CreatedeckState();
}

class _CreatedeckState extends State<Createdeck> {
  String? deckName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20,),
        Text(
          'Add Deck',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20,),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Deck Name',
          ),
          onSubmitted: (text) {
            print('$text');
            // Handle the entered text here
          },
        )
      ],
    );
  }
}

class Maindeck extends StatefulWidget {
  @override
  State<Maindeck> createState() => _MaindeckState();
}

class _MaindeckState extends State<Maindeck> {
  var selectedIndex = 0;

  var pages = <Widget>[
    Padding(child: const Text("hello"), padding: EdgeInsets.all(8.0)),
    Createdeck()
  ];

  @override
  Widget build(BuildContext context) {
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
