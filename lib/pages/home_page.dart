import 'package:flutter/material.dart';
import 'package:pokedex/pages/favorites_page.dart';
import 'package:pokedex/pages/pokemons_page.dart';
import 'package:pokedex/pages/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  PageController pageController = PageController();

  //Change the page and animate
  void onTapped(int index) {
    setState(() {
      selectedIndex = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          PokemonsPage(),
          FavoritesPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onTapped,
      ),
    );
  }
}
