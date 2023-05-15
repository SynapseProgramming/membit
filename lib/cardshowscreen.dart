import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CardShowScreen extends StatefulWidget {
  const CardShowScreen({super.key});

  @override
  State<CardShowScreen> createState() => _CardShowScreenState();
}

class _CardShowScreenState extends State<CardShowScreen> {
  @override
  Widget build(BuildContext context) {
    var router = context.router;
    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(onPressed: () => router.pop(), child: Text('back'))
        ],
      ),
    );
  }
}
