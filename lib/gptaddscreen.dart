import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GptAddScreen extends StatefulWidget {
  const GptAddScreen({super.key, required this.DeckName});

  final String DeckName;

  @override
  State<GptAddScreen> createState() => _GptAddScreenState();
}

class _GptAddScreenState extends State<GptAddScreen> {
  @override
  Widget build(BuildContext context) {
    var router = context.router;
    return ElevatedButton(
        onPressed: () {
          router.pop();
        },
        child: Text(widget.DeckName));
  }
}
