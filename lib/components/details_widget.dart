import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.list,
    required this.pokeIndex,
    required this.pokemon,
    required this.onChange,
  }) : super(key: key);

  final List<Pokemon> list;
  final int pokeIndex;
  final Pokemon pokemon;
  final ValueChanged<Pokemon> onChange;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PageController controller = PageController(
      initialPage: pokeIndex,
      viewportFraction: 0.65,
      keepPage: true,
    );

    return Stack(
      children: [
        Container(
          height: height * 0.5,
          color: Colors.red,
          child: PageView(
            onPageChanged: (value) {
              onChange(list[value]);
            },
            controller: controller,
            children: list
                .map(
                  (e) => Image.network(e.imageurl!),
                )
                .toList(),
          ),
        ),
        Positioned(
          top: height * 0.02,
          child: TextButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              overlayColor: MaterialStateProperty.all(Colors.black12),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 32,
            ),
          ),
        ),
        Positioned(
          right: width * 0.05,
          top: height * 0.026,
          child: Text(
            "${pokemon.name!}\n${pokemon.id}",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
