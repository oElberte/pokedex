import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokedex/components/favorite_button_widget.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/utils/state_manager.dart';
import 'package:simple_shadow/simple_shadow.dart';

typedef IntCallback = void Function(int id);

class DetailsWidget extends StatelessWidget {
  const DetailsWidget({
    Key? key,
    required this.list,
    required this.pokemon,
    required this.index,
    required this.callback,
  }) : super(key: key);

  final List<Pokemon> list;
  final Pokemon pokemon;
  final int index;
  final IntCallback callback;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    PageController controller = PageController(
      initialPage: index,
      viewportFraction: 0.65,
      keepPage: true,
    );

    return Stack(
      children: [
        //Background
        Container(
          decoration: BoxDecoration(
            color: Pokemon.color(type: list[index].type![0]),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(60),
              topRight: Radius.circular(60),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, -5), //Changes the position of shadow
              ),
            ],
          ),
          height: height * 0.5,
          //Pokemon image
          child: PageView(
            onPageChanged: (value) => callback(value),
            controller: controller,
            children: list
                .map(
                  (e) => Stack(
                    children: [
                      Positioned.fill(
                        bottom: 25,
                        child: Align(
                          alignment: Alignment.center,
                          child: SimpleShadow(
                            offset: const Offset(4, 6),
                            sigma: 7,
                            child: Image.network(
                              e.imageurl!,
                              scale: 0.5,
                              width: 250,
                              height: 250,
                              cacheWidth: 250,
                              cacheHeight: 250,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
        //Favorite button
        FavoriteButton(
          list: list,
          index: index,
        ),
        //Arrow back
        Positioned.fill(
          left: 15,
          top: 13,
          child: Align(
            alignment: Alignment.topLeft,
            //Consumer here
            child: Consumer(builder: (context, ref, child) {
              return TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(const CircleBorder()),
                  overlayColor: MaterialStateProperty.all(Colors.black12),
                ),
                onPressed: () {
                  Navigator.of(context).pop(index);
                  ref.refresh(pokemonStateFuture);
                },
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 42,
                ),
              );
            }),
          ),
        ),
        //Name and ID
        Positioned.fill(
          bottom: 15,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 32,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '${list[index].name}\n',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: list[index].id,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //Type of pokemon
        Positioned(
          top: 22,
          right: 30,
          child: Row(
            children: list[index]
                .type!
                .map(
                  (item) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    margin: const EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      color: Pokemon.color(type: item),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Text(
                      item,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
