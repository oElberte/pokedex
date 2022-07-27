import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/components/pokemon_grid_item.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/utils/state_manager.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Pokemon>> favoritePokemons = ref.watch(openBox);
    ref.refresh(openBox);

    return Scaffold(
      body: SafeArea(
        child: favoritePokemons.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stack) => Center(
            child: Text(error.toString()),
          ),
          data: (favoritePokemons) {
            return favoritePokemons.isEmpty
                ? const Center(
                    child: Text(
                      'No favorite Pokémons yet...',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : GridView.builder(
                    // controller: controller,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: favoritePokemons.length,
                    itemBuilder: (ctx, i) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => PokemonDetailsPage(
                                pokemon: favoritePokemons[i],
                                list: favoritePokemons,
                              ),
                            ),
                          );
                        },
                        child: PokemonGridItem(
                          favoritePokemons,
                          i,
                          localStorage,
                          key: ValueKey(favoritePokemons[i].id),
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
