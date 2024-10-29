import 'package:flutter/material.dart';
import '../models/meal.dart';

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
          // Naviguer vers les détails du repas
        },
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image du repas
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(4.0)),
                child: Image.network(
                  meal.imageUrl,
                  height: 100.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Informations du repas
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  meal.nom,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('${meal.calories} kcal'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Action lors du clic
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
