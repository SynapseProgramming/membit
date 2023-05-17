import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:membit/entities/deck.dart';
import 'package:membit/entities/card.dart' as deckcard;
import 'package:membit/isardb.dart';
import 'package:membit/main.dart';
import 'package:membit/router.gr.dart';

@RoutePage()
class CardShowScreen extends StatefulWidget {
  const CardShowScreen({super.key, required this.currentDeck});

  final Deck currentDeck;

  @override
  State<CardShowScreen> createState() => _CardShowScreenState();
}

class _CardShowScreenState extends State<CardShowScreen> {
  List<deckcard.Card> cards = [];
  bool fired = false;
  int current_index = 0;
  bool show = false;
  double complete_ratio = 0;

  Future<void> getCards(IsarDb db) async {
    if (fired == false) {
      cards = await db.getCardsFor(widget.currentDeck);
      setState(() {
        fired = true;
        current_index = 0;
        complete_ratio = 0;
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
                value: complete_ratio,
                semanticsLabel: "ok",
                color: Colors.green,
                backgroundColor: Colors.white,
              ),
            ),
          )),
      body: Visibility(
          visible: cards.isNotEmpty,
          child: cards.length > 0 && current_index < cards.length
              ? Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () => setState(() {
                          show = true;
                        }),
                        child: Container(
                          width: 300,
                          height: 500,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                          child: Column(children: [
                            Text(
                              cards[current_index].front,
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Arial',
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Visibility(
                              visible: show,
                              child: Text(cards[current_index].back,
                                  style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Arial',
                                    color: Colors.green,
                                  )),
                            ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                      visible: show,
                      child: ElevatedButton(
                        onPressed: () => {
                          setState(
                            () {
                              show = false;
                              current_index++;
                              complete_ratio = current_index / cards.length;
                            },
                          )
                        },
                        child: Text('next'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.green),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Deck Completed!",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial',
                          color: Colors.black,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          setState(
                            () {
                              router.navigate(const DeckRoute());
                            },
                          )
                        },
                        child: Text('return'),
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(200, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.green),
                      ),
                    ],
                  ),
                ),
          replacement: const Text("NO CARDS")),
    );
  }
}
