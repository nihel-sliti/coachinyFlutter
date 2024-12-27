import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_item.dart';
import '../widgets/filter_modal.dart';

class MealRecommendationsScreen extends StatelessWidget {
  const MealRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);
    final meals = mealProvider.meals;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF8FD),
      appBar: AppBar(
        title: const Text('Recommandations de Repas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Ouvrir le modal de filtrage
              showModalBottomSheet(
                context: context,
                builder: (_) => FilterModal(),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              // Gérer le tri
              bool ascending = true; // ou false selon vos besoins
              mealProvider.sortMealsBy(value, ascending);
            },
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: 'Temps de préparation',
                child: Text('Temps de préparation'),
              ),
              const PopupMenuItem(
                value: 'Calories',
                child: Text('Calories'),
              ),
            ],
          ),
        ],
      ),
      body: meals.isEmpty
          ? const Center(child: Text('Aucun repas ne correspond aux critères.'))
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (ctx, index) => MealItem(meal: meals[index]),
            ),
    );
  }
}
