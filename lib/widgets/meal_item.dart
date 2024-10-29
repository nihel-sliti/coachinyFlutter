import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../screens/meal_detail_screen.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem({Key? key, required this.meal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Définir une taille pour le conteneur de l'image
    const double imageSize = 50.0;

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: _buildMealImage(),
        title: Text(
          meal.name ?? 'Nom inconnu', // Valeur par défaut si name est null
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${meal.calories ?? 0} kcal - ${meal.preparationTime ?? 0} min', // Valeurs par défaut si calories ou preparationTime sont null
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => MealDetailScreen(meal: meal),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealImage() {
    if (meal.imageUrl != null && meal.imageUrl!.isNotEmpty) {
      // Si imageUrl est non-null et non vide, afficher l'image
      return Image.asset(
        meal.imageUrl!,
        width: 50.0,
        height: 50.0,
        fit: BoxFit.cover,
      );
    } else {
      // Sinon, afficher une image par défaut ou une icône
      return Container(
        width: 50.0,
        height: 50.0,
        color: Colors.grey[300],
        child: const Icon(
          Icons.fastfood,
          color: Colors.white,
        ),
      );
    }
  }
}
