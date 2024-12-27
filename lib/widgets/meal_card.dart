import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/meal_detail_screen.dart'; // Assurez-vous d'importer correctement l'écran des détails

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      margin: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          // Naviguer vers MealDetailScreen avec les détails du repas
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailScreen(meal: meal),
            ),
          );
        },
        child: Card(
          color: const Color(0xFF40B491),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image du repas avec gestion des erreurs
              Center(
                child: ClipOval(
                  child: meal.imageUrl != null && meal.imageUrl!.isNotEmpty
                      ? Image.asset(
                          meal.imageUrl!,
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/Poulet_grille.png',
                          height: 100.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              // Nom du repas
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  meal.name ?? 'Nom inconnu',
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),

              // Calories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  '${meal.calories ?? 0} kcal',
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white70,
                  ),
                ),
              ),

              const Spacer(),

              // Ligne avec calories et icône de favoris
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${meal.calories ?? 0} KCL',
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite_outline,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // Action pour ajouter aux favoris
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
