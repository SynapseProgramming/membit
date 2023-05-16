import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/entities/card.dart' as deckcard;
import 'package:membit/isardb.dart';
import 'package:membit/main.dart';

@RoutePage()
class CardShowScreen extends StatefulWidget {
  CardShowScreen({super.key, required this.currentDeck});

  late Deck currentDeck;

  @override
  State<CardShowScreen> createState() => _CardShowScreenState();
}

class _CardShowScreenState extends State<CardShowScreen> {
  List<deckcard.Card> cards = [];
  bool fired = false;

  Future<void> getCards(IsarDb db) async {
    if (fired == false) {
      cards.clear();
      cards = await db.getCardsFor(widget.currentDeck);
      setState(() {
        fired = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var router = context.router;
    final dbref = DbAccess.of(context).dbinstance;
    getCards(dbref);
    for (var kek in cards) {
      print(kek.front);
    }
    print(cards.length);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: () {
                router.pop();
              },
              icon: const Icon(Icons.arrow_back)),
          title: SizedBox(
            width: 250,
            height: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: 0.5,
                semanticsLabel: "ok",
                color: Colors.green,
                backgroundColor: Colors.white,
              ),
            ),
          )),
      body: Column(),
    );
  }
}
