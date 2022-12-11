import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'base_local_storage.dart';
import '../pokemon.dart';

class LocalStorage extends BaseLocalStorage with ChangeNotifier {
  String favoritesBox = 'favorites';

  @override
  Future<Box> openBox() async {
    Box box = await Hive.openBox<Pokemon>(favoritesBox);
    return box;
  }

  @override
  List<Pokemon> getFavorites(Box box) {
    return box.values.toList() as List<Pokemon>;
  }

  @override
  Future<void> addFavorite(Box box, Pokemon pokemon) async {
    if (box.containsKey(pokemon.id)) {
      await box.delete(pokemon.id);
      notifyListeners();
    } else {
      await box.put(pokemon.id, pokemon);
    }
  }

  @override
  Future<void> clearFavorites(Box box) async {
    await box.clear();
  }
}
