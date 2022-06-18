import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/services/pokemon_api.dart';

final pokemonStateFuture = FutureProvider<List<Pokemon>>((ref) async {
  return fetchPokemons();
});
