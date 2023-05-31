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
      cards.sort((a, b) => b.difficulty.compareTo(a.difficulty));
      setState(() {
        fired = true;
        current_index = 0;
        complete_ratio = 0;
      });
    }
  }

  void nextCard() {
    setState(
      () {
        show = false;
        current_index++;
        complete_ratio = current_index / cards.length;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var router = context.router;
    final dbref = DbAccess.of(context).dbinstance;
    getCards(dbref);
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
          ),
          actions: [
            Center(
                child: Text((current_index + 1).toString() +
                    "/" +
                    (cards.length + 1).toString()))
          ],
        ),
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
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 310,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                              width: 0.00001,
                            ),
                          ),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Visibility(
                        visible: show,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                deckcard.Card currentcard =
                                    cards[current_index];
                                currentcard.difficulty = 1;
                                dbref.saveCard(currentcard);
                                nextCard();
                              },
                              child: Text('Easy'),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(120, 60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.green),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                deckcard.Card currentcard =
                                    cards[current_index];
                                currentcard.difficulty = 3;
                                dbref.saveCard(currentcard);

                                nextCard();
                              },
                              child: Text('Hard'),
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(120, 60),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  backgroundColor: Colors.orange),
                            ),
                          ],
                        )),
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
          replacement: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "No Cards!",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
