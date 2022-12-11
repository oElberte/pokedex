import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../models/database/local_storage.dart';
import '../models/pokemon.dart';

class PokemonGridItem extends StatefulWidget {
  const PokemonGridItem(
    this.pokemons,
    this.i,
    this.localStorage, {
    Key? key,
  }) : super(key: key);

  final List<Pokemon> pokemons;
  final int i;
  final LocalStorage localStorage;

  @override
  State<PokemonGridItem> createState() => _PokemonGridItemState();
}

class _PokemonGridItemState extends State<PokemonGridItem> {
  @override
  void initState() {
    pokemons = widget.pokemons;
    i = widget.i;
    localStorage = widget.localStorage;
    super.initState();
  }

  late List<Pokemon> pokemons;
  late int i;
  late LocalStorage localStorage;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                color: Colors.black.withOpacity(0.4),
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
        //Pokemon name and type
        Positioned.fill(
          left: pokemons[i].name!.length >= 10 ? 7 : 5,
          top: pokemons[i].name!.length >= 10 ? 7 : 5,
          child: Text(
            pokemons[i].name!,
            style: TextStyle(
              color: Colors.white,
              fontSize: pokemons[i].name!.length >= 10 ? 18 : 20,
            ),
          ),
        ),
        Positioned.fill(
          right: 5,
          top: 9,
          child: Align(
            alignment: Alignment.topRight,
            child: Column(
              children: pokemons[i]
                  .type!
                  .map(
                    (item) => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
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
        ),
        //Pokemon id and favorite button
        Positioned.fill(
          bottom: 5,
          right: 7,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  color: Colors.white,
                  constraints: const BoxConstraints(
                    maxWidth: 34,
                    maxHeight: 36,
                  ),
                  iconSize: 28,
                  icon:
                      Hive.box<Pokemon>('favorites').containsKey(pokemons[i].id)
                          ? const Icon(Icons.favorite)
                          : const Icon(Icons.favorite_border),
                  onPressed: () async {
                    Box box = await localStorage.openBox();
                    localStorage.addFavorite(box, pokemons[i]);
                    setState(() {});
                  },
                ),
                Text(
                  pokemons[i].id!.toString(),
                  style: const TextStyle(
                    color: Color.fromARGB(70, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
