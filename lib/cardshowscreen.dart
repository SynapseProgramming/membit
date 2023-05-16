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

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => router.pop(),
                icon: Icon(Icons.cancel_rounded),
                color: Colors.blue,
              ),
              SizedBox(
                width: 250,
                height: 20,
                child: LinearProgressIndicator(
                  value: 0.1,
                  semanticsLabel: "ok",
                  color: Colors.green,
                  backgroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
