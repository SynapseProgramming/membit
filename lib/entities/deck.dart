import 'package:isar/isar.dart';
import 'card.dart';

part 'deck.g.dart';

@collection
class Deck {
  Id id = Isar.autoIncrement;
  late String name;

  @Backlink(to: 'deck')
  final cards = IsarLinks<Card>();

}
