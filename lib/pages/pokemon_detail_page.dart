import 'package:flutter/material.dart';
import 'package:pokedex/components/details_widget.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage({
    Key? key,
    required this.pokemon,
    required this.list,
  }) : super(key: key);

  final Pokemon pokemon;
  final List<Pokemon> list;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  //pokemon.id
  @override
  Widget build(BuildContext context) {
    final index = widget.list
        .indexWhere((element) => element.name == widget.pokemon.name);
    Pokemon newPoke = widget.pokemon;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                newPoke.xdescription!,
                textAlign: TextAlign.justify,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
          ),
          DetailsWidget(
            list: widget.list,
            pokeIndex: index,
            pokemon: newPoke,
            onChange: (Pokemon pagePoke) {
              setState(() {
                newPoke.id = pagePoke.id;
                newPoke.name = pagePoke.name;
                newPoke.category = pagePoke.category;
                newPoke.typeofpokemon = pagePoke.typeofpokemon;
                newPoke.xdescription = pagePoke.xdescription;
              });
            },
          ),
        ],
      ),
    );
  }
}
