import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/components/pokemon_grid_item.dart';
import 'package:pokedex/models/database/local_storage.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/utils/state_manager.dart';

typedef IntCallback = void Function(int id);

class PokemonsPage extends ConsumerWidget {
  const PokemonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.refresh(openBox);

    final AsyncValue<List<Pokemon>> pokemons = ref.watch(pokemonStateFuture);

    final controller = ScrollController(keepScrollOffset: false);

    final LocalStorage localStorage = LocalStorage();

    Future<void> _navigateAndDisplaySelection(context, pokemons, index) async {
      final int result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (ctx) => PokemonDetailsPage(
            pokemon: pokemons[index],
            list: pokemons,
          ),
        ),
      );
      controller.animateTo(
        (result * 57).toDouble(),
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    }

    return Scaffold(
      body: SafeArea(
        //".when" from Riverpod, used to load all the Pokemons from the API and handle with loading and errors.
        child: pokemons.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stack) => Center(
            child: Text(error.toString()),
          ),
          data: (pokemons) {
            return GridView.builder(
              controller: controller,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: pokemons.length,
              itemBuilder: (ctx, i) {
                return InkWell(
                  onTap: () => _navigateAndDisplaySelection(ctx, pokemons, i),
                  child: PokemonGridItem(
                    pokemons,
                    i,
                    localStorage,
                    key: ValueKey(pokemons[i].id),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
