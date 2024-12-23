import 'package:coachiny/models/ingredient.dart';
import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  List<Meal> _allMeals = []; // Liste complète des repas
  List<Meal> _filteredMeals = [];

  // Critères de filtrage
  String _selectedMealType = 'Tous';
  int _maxPreparationTime = 60; // minutes
  RangeValues _calorieRange = RangeValues(0, 1000);

  // Getters
  List<Meal> get meals => _filteredMeals;

  String get selectedMealType => _selectedMealType;
  int get maxPreparationTime => _maxPreparationTime;
  RangeValues get calorieRange => _calorieRange;

  MealProvider() {
    _loadMeals();
  }

  // Charger les repas (simulation pour l'exemple)
  void _loadMeals() {
    _allMeals = [
      Meal(
        id: 'm1',
        name: 'Salade de Quinoa',
        imageUrl: 'assets/images/Salade_de_Quinoa.png',
        type: 'Déjeuner',
        preparationTime: 20,
        calories: 350,
        ingredients: [
          Ingredient(name: "name", calories: 500, price: 1.4, weight: 100)
        ],
        instructions: 'Mélangez tous les ingrédients...',
      ),
      // Ajoutez d'autres repas...
    ];
    _filteredMeals = List.from(_allMeals);
    notifyListeners();
  }

  // Méthodes de filtrage
  void updateFilters({
    String? mealType,
    int? maxPrepTime,
    RangeValues? calorieRange,
  }) {
    if (mealType != null) _selectedMealType = mealType;
    if (maxPrepTime != null) _maxPreparationTime = maxPrepTime;
    if (calorieRange != null) _calorieRange = calorieRange;

    _applyFilters();
  }

  void _applyFilters() {
    _filteredMeals = _allMeals.where((meal) {
      bool matchesType =
          _selectedMealType == 'Tous' || meal.type == _selectedMealType;
      bool matchesPrepTime = meal.preparationTime != null &&
          meal.preparationTime! <= _maxPreparationTime;
      bool matchesCalories = meal.calories != null &&
          meal.calories! >= _calorieRange.start &&
          meal.calories! <= _calorieRange.end;

      return matchesType && matchesPrepTime && matchesCalories;
    }).toList();
    notifyListeners();
  }

  // Méthode de tri
  void sortMealsBy(String criterion, bool ascending) {
    _filteredMeals.sort((a, b) {
      int comparison;
      if (criterion == 'Temps de préparation') {
        comparison = (a.preparationTime ?? 0).compareTo(b.preparationTime ?? 0);
      } else if (criterion == 'Calories') {
        comparison = (a.calories ?? 0).compareTo(b.calories ?? 0);
      } else {
        comparison = 0;
      }
      return ascending ? comparison : -comparison;
    });
    notifyListeners();
  }
}
