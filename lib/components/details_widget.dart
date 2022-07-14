import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/state_manager.dart';

// ignore: must_be_immutable
class DetailsWidget extends StatefulWidget {
  DetailsWidget({
    Key? key,
    required this.list,
    required this.pokemon,
    required this.index,
  }) : super(key: key);

  final List<Pokemon> list;
  final Pokemon pokemon;
  int index;

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PageController controller = PageController(
      initialPage: widget.index,
      viewportFraction: 0.65,
      keepPage: true,
    );

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: height * 0.5),
          Stack(
            children: [
              Container(
                height: height * 0.5,
                color: Pokemon.color(
                  type: widget.list[widget.index].typeofpokemon![0],
                ),
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      widget.index = value;
                    });
                  },
                  controller: controller,
                  children: widget.list
                      .map(
                        (e) => Image.network(e.imageurl!),
                      )
                      .toList(),
                ),
              ),
              Consumer(
                builder: (context, ref, child) {
                  return Positioned(
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
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.refresh(pokemonStateFuture);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                right: width * 0.05,
                top: height * 0.026,
                child: Text(
                  "${widget.list[widget.index].name}\n${widget.list[widget.index].id}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
