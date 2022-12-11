import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../components/pokemon_grid_item.dart';
import '../models/database/local_storage.dart';
import '../models/pokemon.dart';
import 'pokemon_detail_page.dart';
import '../utils/state_manager.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

typedef IntCallback = void Function(int id);

class PokemonsPage extends ConsumerStatefulWidget {
  const PokemonsPage({Key? key}) : super(key: key);

  @override
  ConsumerState<PokemonsPage> createState() => _PokemonsPageState();
}

class _PokemonsPageState extends ConsumerState<PokemonsPage> {
  @override
  Widget build(BuildContext context) {
    ref.refresh(openBox);
    final AsyncValue<List<Pokemon>> pokemons = ref.watch(pokemonStateFuture);

    final LocalStorage localStorage = LocalStorage();

    final controller = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
      suggestedRowHeight: 120,
    );

    Future<void> navigateAndDisplaySelection(
        BuildContext ctx, List<Pokemon> pokemons, int index) async {
      await Navigator.push(
        ctx,
        MaterialPageRoute(
          builder: (ctx) => PokemonDetailsPage(
            pokemon: pokemons[index],
            list: pokemons,
          ),
        ),
      );

      setState(() {});

      await controller.scrollToIndex(
        index,
        preferPosition: AutoScrollPosition.begin,
        duration: const Duration(milliseconds: 500),
      );
    }

    return Scaffold(
      body: SafeArea(
        //".when" from Riverpod, used to load all the Pokemons from the API and handle with loading and errors.
        child: pokemons.when(
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stack) => Center(
            child: Text(error.toString()),
          ),
          data: (pokemons) {
            return GridView.builder(
              controller: controller,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: pokemons.length,
              itemBuilder: (ctx, i) {
                //AutoScrollTag used for when user backs from mainscreen it goes to index.
                return AutoScrollTag(
                  key: ValueKey(i),
                  controller: controller,
                  index: i,
                  child: InkWell(
                    onTap: () =>
                        navigateAndDisplaySelection(context, pokemons, i),
                    child: PokemonGridItem(pokemons, i, localStorage),
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
