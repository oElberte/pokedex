import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/state_manager.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    AsyncValue<List<Pokemon>> pokemons = ref.read(pokemonStateFuture);

    return Scaffold(
      body: pokemons.when(
        data: (pokemons) => ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, i) {
            return Image.network(pokemons[i].imageurl!);
          },
        ),
        error: (error, stack) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
