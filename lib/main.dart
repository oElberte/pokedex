import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/pages/favorites_page.dart';
import 'package:pokedex/pages/home_page.dart';
import 'package:pokedex/pages/pokemon_detail_page.dart';
import 'package:pokedex/pages/settings_page.dart';
import 'package:pokedex/utils/app_routes.dart';

void main() {
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ),
      ),
      routes: {
        AppRoutes.home: (ctx) => const HomePage(),
        AppRoutes.favorites: (ctx) => const FavoritesPage(),
        AppRoutes.settings: (ctx) => const SettingsPage(),
        AppRoutes.pokemonDetails: (ctx) => const PokemonDetailsPage(),
      },
    );
  }
}
