import 'package:coachiny/screens/productContent.dart';
import 'package:flutter/material.dart';
import 'package:coachiny/screens/FavoritesScreen.dart';
import 'package:coachiny/screens/HomeScreen.dart';
import 'package:coachiny/screens/Panierscreen.dart';

class Productscreen extends StatefulWidget {
  @override
  _ProductscreenState createState() => _ProductscreenState();
}

class _ProductscreenState extends State<Productscreen> {
  int _selectedIndex = 0;

  // Liste des pages à afficher
  final List<Widget> _pages = <Widget>[
    ProductContent(), // Contenu spécifique à Productscree
    Panierscreen(),
    FavoritesScreen(),
  ];

  void _onItemTapped(int index) {
    print('Item tapped: $index'); // Pour le débogage
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What is in your kitchen?'),
        actions: const [
          CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                "https://pharma-shop.tn/16471-large_default/impact-proteine-isolate-whey-.webp"),
          ),
        ],
      ),
      body: _pages[_selectedIndex], // Affiche la page sélectionnée
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_bar_sharp), label: 'Products'),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        currentIndex: _selectedIndex, // Index actuellement sélectionné
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
