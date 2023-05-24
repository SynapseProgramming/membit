class CardJson {
  CardJson({required this.front, required this.back});

  final String front;
  final String back;

  factory CardJson.fromJson(Map<String, dynamic> data) {
    final String front = data['front'] as String;
    final String back = data['back'] as String;
    return CardJson(front: front, back: back);
  }
}

class FlashCardsJson {
  FlashCardsJson({required this.cards});
  final List<CardJson> cards;

  factory FlashCardsJson.fromJson(Map<String, dynamic> data) {
    final cardsdata = data["flashcards"] as List<dynamic>?;
    final c = cardsdata != null
        ? cardsdata.map((e) => CardJson.fromJson(e)).toList()
        : <CardJson>[];
    return FlashCardsJson(cards: c);
  }
}
