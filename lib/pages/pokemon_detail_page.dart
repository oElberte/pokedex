import 'package:flutter/material.dart';
import 'package:pokedex/components/details_widget.dart';
import 'package:pokedex/models/pokemon.dart';

class PokemonDetailsPage extends StatelessWidget {
  const PokemonDetailsPage({
    Key? key,
    required this.pokemon,
    required this.list,
  }) : super(key: key);

  final Pokemon pokemon;
  final List<Pokemon> list;

  //pokemon.id
  @override
  Widget build(BuildContext context) {
    final index = list.indexWhere((element) => element.name == pokemon.name);

    return DetailsWidget(
      list: list,
      index: index,
      pokemon: pokemon,
    );
  }
}
