import 'package:isar/isar.dart';
import 'package:membit/entities/card.dart';
import 'package:membit/entities/deck.dart';
import 'package:path_provider/path_provider.dart';

class IsarDb {
  late Future<Isar> db;
  IsarDb() {
    db = openDB();
  }
  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([CardSchema, DeckSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }

  Stream<List<Deck>> listenDecks() async* {
    final isar = await db;
    yield* isar.decks.where().watch(fireImmediately: true);
  }

  Future<void> saveDeck(Deck newDeck) async {
    final isar = await db;
    final matchDecks = isar.decks.filter().nameMatches(newDeck.name).build();
    final has = await matchDecks.isEmpty();
    if (has) {
      isar.writeTxnSync(() => isar.decks.putSync(newDeck));
    }
  }

  Future<Deck?> getDeck(String deckName) async {
    final isar = await db;
    final match = isar.decks.filter().nameMatches(deckName);
    return match.findFirst();
  }

  Future<void> saveCard(Card newCard) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.cards.putSync(newCard));
  }

  Future<List<Card>> getCardsFor(Deck deck) async {
    final isar = await db;
    return await isar.cards
        .filter()
        .deck((q) => q.idEqualTo(deck.id))
        .findAll();
  }
}
