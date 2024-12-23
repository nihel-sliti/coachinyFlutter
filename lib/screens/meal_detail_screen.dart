import 'package:coachiny/providers/FavoriteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;
  static const IconData shopping_cart =
      IconData(0xe59c, fontFamily: 'MaterialIcons');

  const MealDetailScreen({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFavorite =
        favoriteProvider.isFavorite(meal); // Check if the meal is favorite

    return Scaffold(
      backgroundColor: const Color(0xFFEFF8FD), // Background color
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          meal.name ?? 'Détails du Repas',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(shopping_cart, color: Colors.grey),
            onPressed: () {
              /* Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Panier(cartItems: cartItems),
                ),
              );*/
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meal Image
              _buildMealImage(),
              const SizedBox(height: 16.0),

              // Meal name and calories
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    meal.name ?? 'Nom inconnu',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${meal.calories ?? 0} KCL',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),

              // Cooking time and favorite icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Calories
                      Row(
                        children: [
                          const Icon(Icons.local_fire_department,
                              color: Colors.red),
                          const SizedBox(width: 4.0),
                          Text(
                            '${meal.calories ?? 0} Calories',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16.0),

                      // Time to cook
                      Row(
                        children: [
                          const Icon(Icons.timer, color: Colors.blue),
                          const SizedBox(width: 4.0),
                          Text(
                            '${meal.preparationTime ?? 0} min',
                            style: const TextStyle(
                                fontSize: 16.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Favorite button
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      if (isFavorite) {
                        // Remove from favorites
                        favoriteProvider.removeMealFromFavorites(meal);
                      } else {
                        // Add to favorites
                        favoriteProvider.addMealToFavorites(meal);
                      }
                    },
                  )
                ],
              ),
              const SizedBox(height: 16.0),

              // Ingredients section
              const Text(
                'Ingrédients',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              if (meal.ingredients != null && meal.ingredients!.isNotEmpty)
                ...meal.ingredients!.map(
                  (ingredient) => const Row(
                    children: [
                      Icon(Icons.check, color: Colors.green),
                      SizedBox(width: 8.0),
                      //  Text(
                      // ingredient,
                      // style: const TextStyle(fontSize: 16),
                      // ),
                    ],
                  ),
                ),
              if (meal.ingredients == null || meal.ingredients!.isEmpty)
                const Text(
                  'Aucun ingrédient disponible.',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              const SizedBox(height: 16.0),

              // Details section
              const Text(
                'Détails',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                meal.description ?? 'Aucune information supplémentaire.',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16.0),

              // Instructions section
              const Text(
                'Instructions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                meal.instructions ?? 'Aucune instruction disponible.',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to display the meal image with rounded corners
  Widget _buildMealImage() {
    if (meal.imageUrl != null && meal.imageUrl!.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.network(
          meal.imageUrl!,
          height: 250.0,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/Poulet_grille.png',
              height: 250.0,
              width: double.infinity,
              fit: BoxFit.cover,
            );
          },
        ),
      );
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Image.asset(
          'assets/images/Poulet_grille.png',
          height: 250.0,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }
  }
}
