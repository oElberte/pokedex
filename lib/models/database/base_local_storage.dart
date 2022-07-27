import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/models/pokemon.dart';

abstract class BaseLocalStorage {
  Future<Box> openBox();
  List<Pokemon> getFavorites(Box box);
  Future<void> addFavorite(Box box, Pokemon pokemon);
  Future<void> clearFavorites(Box box);
}
