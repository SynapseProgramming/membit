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

  Future<void> saveDeck(Deck newDeck) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.decks.putSync(newDeck));
  }
  
}
