import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/utils/state_manager.dart';
import 'package:simple_shadow/simple_shadow.dart';

class PokemonsPage extends ConsumerWidget {
  const PokemonsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    final AsyncValue<List<Pokemon>> pokemons = ref.watch(pokemonStateFuture);

    return Scaffold(
      body: SafeArea(
        //".when" used to load all the Pokemons from the API and handle with loading and errors.
        child: pokemons.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stack) => Center(
            child: Text(error.toString()),
          ),
          data: (pokemons) {
            return GridView.builder(
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
                  onTap: () => Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder: (ctx) => PokemonDetailsPage(
                        pokemon: pokemons[i],
                        list: pokemons,
                      ),
                    ),
                  ),
                  child: Stack(
                    children: [
                      //Container for each Pokemon
                      Container(
                        decoration: BoxDecoration(
                          color: Pokemon.color(
                            type: pokemons[i].type![0],
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.6),
                              blurRadius: 4,
                              offset: const Offset(3, 3),
                            ),
                          ],
                        ),
                      ),
                      //Pokemon image
                      Positioned(
                        bottom: 5,
                        left: 5,
                        child: SimpleShadow(
                          opacity: 0.3,
                          offset: const Offset(2, 4),
                          sigma: 3,
                          child: Image.network(
                            pokemons[i].imageurl!,
                            height: 80,
                            width: 80,
                            cacheHeight: 160,
                            cacheWidth: 160,
                          ),
                        ),
                      ),
                      //Pokemon name
                      Positioned(
                        top: 5,
                        left: 5,
                        child: Text(
                          pokemons[i].name!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //Pokemon id
                      Positioned(
                        bottom: 5,
                        right: 10,
                        child: Text(
                          pokemons[i].id!.toString(),
                          style: const TextStyle(
                            color: Color.fromARGB(70, 255, 255, 255),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //Pokemon types
                      Positioned(
                        top: 9,
                        right: 8,
                        child: Column(
                          children: pokemons[i]
                              .type!
                              .map(
                                (item) => Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  margin: const EdgeInsets.only(top: 1),
                                  decoration: const BoxDecoration(
                                    color: Color.fromARGB(50, 255, 255, 255),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                  ),
                                  child: Text(
                                    item,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
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
