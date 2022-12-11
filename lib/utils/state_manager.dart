import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/database/local_storage.dart';
import '../models/pokemon.dart';
import '../services/pokemon_api.dart';

final pokemonStateFuture = FutureProvider<List<Pokemon>>((ref) async {
  return fetchPokemons();
});

final LocalStorage localStorage = LocalStorage();

final openBox = FutureProvider<List<Pokemon>>((ref) async {
  Box box = await localStorage.openBox();
  List<Pokemon> pokemons = localStorage.getFavorites(box);

  return pokemons;
});
