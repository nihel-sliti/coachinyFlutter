import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Meal meal;

  const MealDetailScreen({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8FD),
      appBar: AppBar(
        title: Text(meal.name ?? 'Détails du Repas'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMealImage(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                meal.name ?? 'Nom inconnu',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${meal.calories ?? 0} kcal - ${meal.preparationTime ?? 0} min',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ingrédients',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Affichage des ingrédients
            if (meal.ingredients != null && meal.ingredients!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: meal.ingredients!
                      .map(
                        (ingredient) => ListTile(
                          leading: const Icon(Icons.check),
                          title: Text(ingredient),
                        ),
                      )
                      .toList(),
                ),
              ),
            if (meal.ingredients == null || meal.ingredients!.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Aucun ingrédient disponible.',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Instructions',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                meal.instructions ?? 'Aucune instruction disponible.',
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Méthode pour afficher l'image du repas avec gestion des erreurs
  Widget _buildMealImage() {
    if (meal.imageUrl != null && meal.imageUrl!.isNotEmpty) {
      return Image.network(
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
      );
    } else {
      return Image.asset(
        'assets/images/Poulet_grille.png',
        height: 250.0,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }
}
