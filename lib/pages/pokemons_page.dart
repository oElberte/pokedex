import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/components/pokemons.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/state_manager.dart';

class PokemonsPage extends ConsumerWidget {
  const PokemonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    AsyncValue<List<Pokemon>> pokemons = ref.watch(pokemonStateFuture);

    return Scaffold(
      body: Pokemons(
        pokemons: pokemons,
      ),
    );
  }
}
