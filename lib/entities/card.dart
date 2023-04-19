import 'package:isar/isar.dart';
import 'deck.dart';

part 'card.g.dart';

@collection
class Card {
  Id id = Isar.autoIncrement;
  late String front;
  late String back;
  late int difficulty;
  final deck = IsarLink<Deck>();
}
