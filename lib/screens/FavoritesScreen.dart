import 'package:coachiny/providers/FavoriteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coachiny/models/meal.dart';

class FavoritesScreen extends StatefulWidget {
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();
    // Charger les recettes favorites depuis SharedPreferences
    Provider.of<FavoriteProvider>(context, listen: false)
        .loadFavoritesFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = Provider.of<FavoriteProvider>(context).favoriteMeals;
    // Filtrer les repas aimés (isLiked == true)
    final likedMeals = favoriteMeals.where((meal) => meal.isLiked).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recettes Aimées'),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: likedMeals.isEmpty
          ? const Center(child: Text('Aucune recette aimée pour le moment.'))
          : ListView.builder(
              itemCount: likedMeals.length,
              itemBuilder: (ctx, index) {
                final meal = likedMeals[index];
                return ListTile(
                  title: Text(meal.name ?? 'Inconnu'),
                  subtitle: Text('${meal.calories} Calories'),
                  leading: Image.network(meal.imageUrl ?? ''),
                  onTap: () {
                    // Ajouter la logique de navigation ou d'interaction ici
                  },
                );
              },
            ),
    );
  }
}
