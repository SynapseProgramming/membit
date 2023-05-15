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

  Future<void> getCards(IsarDb db) async {
    cards.clear();
    cards = await db.getCardsFor(widget.currentDeck);
  }

  @override
  Widget build(BuildContext context) {
    var router = context.router;
    final dbref = DbAccess.of(context).dbinstance;
    getCards(dbref);
    print("yay");
    cards.forEach((element) => print(element.front));

    return SafeArea(
      child: Column(
        children: [
          ElevatedButton(onPressed: () => router.pop(), child: Text('back'))
        ],
      ),
    );
  }
}
