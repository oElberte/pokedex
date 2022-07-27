import 'package:flutter/material.dart';
import 'package:pokedex/components/details_widget.dart';
import 'package:pokedex/models/pokemon.dart';

typedef IntCallback = void Function(int id);

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
  @override
  void initState() {
    pokemon = widget.pokemon;
    list = widget.list;
    index = list.indexWhere((element) => element.name == widget.pokemon.name);
    super.initState();
  }

  late List<Pokemon> list;
  late Pokemon pokemon;
  late int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          //Pokemon description
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 8,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  list[index].description!,
                  style: const TextStyle(fontSize: 26),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
          Stack(
            children: [
              //Where the Pokemon image, name and ID are shown
              Align(
                alignment: Alignment.bottomCenter,
                child: DetailsWidget(
                  list: list,
                  index: index,
                  pokemon: pokemon,
                  callback: (val) => setState(() => index = val),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
