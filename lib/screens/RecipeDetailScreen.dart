// lib/screens/Recipedetailscreen.dart

import 'package:coachiny/models/meal.dart';
import 'package:coachiny/models/cart_item.dart';
import 'package:coachiny/screens/panier.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Recipedetailscreen extends StatefulWidget {
  final Meal meal;
  const Recipedetailscreen({Key? key, required this.meal}) : super(key: key);

  @override
  _RecipedetailscreenState createState() => _RecipedetailscreenState();
}

class _RecipedetailscreenState extends State<Recipedetailscreen> {
  late Meal meal;

  @override
  void initState() {
    super.initState();
    meal = widget.meal;
  }

  Future<void> _saveMealToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final String mealJson = jsonEncode(meal.toJson());
    await prefs.setString(meal.name!, mealJson);
  }

  void _showFavoriteSnackbar(BuildContext context, bool isFavorite) {
    final snackBar = SnackBar(
      content: Text(isFavorite
          ? 'Recette ajoutée aux favoris!'
          : 'Recette retirée des favoris!'),
      duration: Duration(seconds: 2),
      backgroundColor: isFavorite ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Liste des éléments du panier, à gérer avec un state management dans une vraie app
  List<CartItem> cartItems = [];

  void _addToCart() {
    CartItem cartItem = CartItem(
      imageUrl: meal.imageUrl ?? '',
      name: meal.name ?? 'Unknown Meal',
      calories: meal.calories ?? 0,
      time: meal.preparationTime ?? 0,
      ingredients: meal.ingredients ?? [],
      quantity: 1, // Quantité par défaut est 1
      price: meal.price ?? 0.0, // Supposant que meal a un champ price
    );
    setState(() {
      cartItems.add(cartItem);
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Panier(cartItems: cartItems),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF8FD), // Couleur de fond
      appBar: AppBar(
        title: Text(meal.name ?? 'Détails du Repas'),
        backgroundColor: Color(0xFF40B491), // Couleur principale
        elevation: 4,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          // Bouton "Ajouter au panier"
          IconButton(
            icon: Icon(Icons.add_shopping_cart, color: Colors.white),
            onPressed: _addToCart, // Ajouter le repas actuel au panier
          ),
        ],
      ),
      body: SingleChildScrollView(
        // Activer le défilement
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Afficher l'image arrondie de grande taille
            _buildMealImage(),
            const SizedBox(height: 16.0),

            // 2. Nom de la recette avec l'icône coeur
            _buildRecipeNameAndHeart(),

            const SizedBox(height: 16.0),

            // 3. Temps de préparation et calories
            _buildMealInfoWithIcons('Calories', '${meal.calories ?? 0} kcal',
                Icons.local_fire_department),
            const SizedBox(height: 10),
            _buildMealInfoWithIcons('Temps de préparation',
                '${meal.preparationTime ?? 0} min', Icons.timer),

            const SizedBox(height: 20),

            // 4. Section des ingrédients
            _buildIngredientsSection(),

            const SizedBox(height: 10),

            // 5. Section Description
            _buildCardSection(
              title: "Description :",
              content: meal.description ?? 'Aucune description disponible.',
            ),

            const SizedBox(height: 10),

            // 6. Section Instructions
            _buildCardSection(
              title: "Instructions :",
              content: meal.instructions ?? 'Aucune instruction disponible.',
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // 1. Fonction d'aide pour afficher l'image arrondie de grande taille
  Widget _buildMealImage() {
    return Center(
      child: ClipOval(
        child: meal.imageUrl != null && meal.imageUrl!.isNotEmpty
            ? Image.network(
                meal.imageUrl!,
                height: 250.0, // Taille plus grande pour l'image
                width: 250.0, // Taille plus grande pour l'image
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/Poulet_grille.png',
                    height: 250.0, // Même taille pour l'image de secours
                    width: 250.0, // Même taille pour l'image de secours
                    fit: BoxFit.cover,
                  );
                },
              )
            : Image.asset(
                'assets/images/Poulet_grille.png',
                height: 250.0, // Même taille pour l'image de secours
                width: 250.0, // Même taille pour l'image de secours
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  // 2. Fonction d'aide pour afficher le nom de la recette avec l'icône coeur
  Widget _buildRecipeNameAndHeart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          meal.name ?? 'Nom de la recette',
          style: TextStyle(
            fontSize: 22, // Taille plus petite pour le nom de la recette
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: Icon(
            meal.isLiked ? Icons.favorite : Icons.favorite_border,
            size: 28,
            color: meal.isLiked ? Colors.red : Colors.grey,
          ),
          onPressed: () async {
            setState(() {
              meal.isLiked = !meal.isLiked;
            });
            await _saveMealToSharedPreferences();
            _showFavoriteSnackbar(context, meal.isLiked);
          },
        ),
      ],
    );
  }

  // 3. Fonction d'aide pour les infos du repas avec icônes (Calories & Temps)
  Widget _buildMealInfoWithIcons(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon,
                color: Color(0xFF40B491)), // Couleur principale pour les icônes
            SizedBox(width: 8),
            Text(label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  // 4. Fonction d'aide pour afficher les ingrédients avec plus de détails
  Widget _buildIngredientsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ingrédients:",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        // Vérifier si la liste des ingrédients n'est pas vide
        if (meal.ingredients != null && meal.ingredients!.isNotEmpty)
          ...meal.ingredients!.map((ingredient) {
            return ListTile(
              title: Text(ingredient.name),
              subtitle: Text(
                  'Calories: ${ingredient.calories} kcal, Poids: ${ingredient.weight}g, Prix: ${ingredient.price} TND'),
            );
          }).toList(),
        if (meal.ingredients == null || meal.ingredients!.isEmpty)
          Text('Ingrédients non disponibles'),
      ],
    );
  }

  // 5. Fonction d'aide pour les sections de type carte (prend la largeur de l'écran)
  Widget _buildCardSection({required String title, required String content}) {
    // Obtenir la largeur de l'écran
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width:
          screenWidth * 0.9, // La carte occupera 90% de la largeur de l'écran
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text(content, style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
