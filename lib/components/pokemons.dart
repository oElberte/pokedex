import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/app_routes.dart';

class Pokemons extends ConsumerWidget {
  const Pokemons({
    Key? key,
    required this.pokemons,
  }) : super(key: key);

  final AsyncValue<List<Pokemon>> pokemons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: pokemons.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text(error.toString())),
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
                onTap: () => Navigator.of(context).pushNamed(
                  AppRoutes.pokemonDetails,
                ),
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 5,
                      width: 80,
                      child: Image.network(pokemons[i].imageurl!),
                    ),
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
                    Positioned(
                      bottom: 5,
                      right: 10,
                      child: Text(
                        pokemons[i].id!,
                        style: const TextStyle(
                          color: Color.fromARGB(70, 255, 255, 255),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 9,
                      right: 8,
                      child: Column(
                        children: pokemons[i]
                            .typeofpokemon!
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
    );
  }
}
