import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widgets/meal_item.dart';
import '../widgets/filter_modal.dart';

class MealRecommendationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);
    final meals = mealProvider.meals;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF8FD),
      appBar: AppBar(
        title: Text('Recommandations de Repas'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
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
              PopupMenuItem(
                child: Text('Temps de préparation'),
                value: 'Temps de préparation',
              ),
              PopupMenuItem(
                child: Text('Calories'),
                value: 'Calories',
              ),
            ],
          ),
        ],
      ),
      body: meals.isEmpty
          ? Center(child: Text('Aucun repas ne correspond aux critères.'))
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (ctx, index) => MealItem(meal: meals[index]),
            ),
    );
  }
}
