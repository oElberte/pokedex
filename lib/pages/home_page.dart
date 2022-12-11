import 'package:flutter/material.dart';
import 'favorites_page.dart';
import 'pokemons_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 1;
  PageController pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

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
          FavoritesPage(),
          PokemonsPage(),
          SettingsPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedIconTheme: const IconThemeData(size: 32),
        selectedFontSize: 16,
        currentIndex: selectedIndex,
        onTap: onTapped,
        items: const [
          BottomNavigationBarItem(
            label: "Favorites",
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
          ),
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Settings",
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
