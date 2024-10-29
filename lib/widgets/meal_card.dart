import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/meal_detail_screen.dart'; // Assurez-vous d'importer la page de détails

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      margin: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          // Naviguer vers les détails du repas
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MealDetailScreen(meal: meal),
            ),
          );
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image du repas avec gestion des erreurs
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4.0)),
                child: meal.imageUrl != null && meal.imageUrl!.isNotEmpty
                    ? Image.asset(
                        meal.imageUrl!,
                        height: 100.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/Poulet_grille.png',
                        height: 100.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              // Informations du repas
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  meal.name ?? 'Nom inconnu',
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('${meal.calories ?? 0} kcal'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Naviguer vers les détails du repas
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MealDetailScreen(meal: meal),
                      ),
                    );
                  },
                  child: const Text('Voir Détails'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
