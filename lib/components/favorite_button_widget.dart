import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/pokemon.dart';
import '../utils/state_manager.dart';

class FavoriteButton extends StatefulWidget {
  const FavoriteButton({
    Key? key,
    required this.list,
    required this.index,
  }) : super(key: key);

  final List<Pokemon> list;
  final int index;

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      left: 19,
      bottom: 23,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: IconButton(
          color: Colors.black,
          iconSize: 42,
          icon: Hive.box<Pokemon>('favorites')
                  .containsKey(widget.list[widget.index].id)
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          onPressed: () async {
            Box box = await localStorage.openBox();
            localStorage.addFavorite(box, widget.list[widget.index]);
            setState(() {});
          },
        ),
      ),
    );
  }
}
