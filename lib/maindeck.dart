import 'package:flutter/material.dart';

class Maindeck extends StatefulWidget {
  @override
  State<Maindeck> createState() => _MaindeckState();
}

class _MaindeckState extends State<Maindeck> {
  var selectedIndex = 0;

  var pages = <Widget>[
            Padding(child: const Text("hello"), padding: EdgeInsets.all(8.0)),Placeholder()];

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
                icon: Icon(Icons.add)),
            actions: [
              IconButton(
                  onPressed: () {
                    print("Delete button pressed");
                  setState(() {
                    selectedIndex = 0;
                  });
                  },
                  icon: Icon(Icons.delete)),
            ],
            title: Center(
              child: const Text(
                'Decks',
              ),
            )),
        body: pages[selectedIndex]);
  }
}
