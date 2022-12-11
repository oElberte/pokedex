import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/pokemon.dart';
import 'pages/home_page.dart';
import 'utils/app_theme.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('themeData');
  Hive.registerAdapter(PokemonAdapter());
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: Hive.box('themeData').listenable(),
        builder: (context, box, widget) {
          var darkMode = Hive.box('themeData').get(
            'darkmode',
            defaultValue: false,
          );

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            home: const HomePage(),
            // routes: {
            //   AppRoutes.home: (ctx) => const HomePage(),
            //   AppRoutes.pokemons: (ctx) => const PokemonsPage(),
            //   AppRoutes.favorites: (ctx) => const FavoritesPage(),
            //   AppRoutes.settings: (ctx) => const SettingsPage(),
            // },
          );
        });
  }
}
