import 'package:flutter/material.dart';

class Maindeck extends StatefulWidget {



  @override
  State<Maindeck> createState() => _MaindeckState();
}

class _MaindeckState extends State<Maindeck> {
  @override
  Widget build(BuildContext context) {
    return Padding(child: Text("hello"), padding: EdgeInsets.all(8.0));
  }
}
