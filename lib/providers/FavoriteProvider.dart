import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:coachiny/models/meal.dart';

class FavoriteProvider with ChangeNotifier {
  List<Meal> _favoriteMeals = [];

  List<Meal> get favoriteMeals => _favoriteMeals;

  // Add a meal to the favorites list
  void addMealToFavorites(Meal meal) async {
    if (!_favoriteMeals.contains(meal)) {
      meal.isLiked = true; // Marquer la recette comme "aimée"
      _favoriteMeals.add(meal);
      await _saveFavoritesToSharedPreferences();
      notifyListeners();
    }
  }

  // Save the favorites list to SharedPreferences
  Future<void> _saveFavoritesToSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> mealList =
        _favoriteMeals.map((meal) => jsonEncode(meal.toJson())).toList();
    await prefs.setStringList('favoriteMeals', mealList);
  }

  // Load the favorites list from SharedPreferences
  Future<void> loadFavoritesFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? mealList = prefs.getStringList('favoriteMeals');
    if (mealList != null) {
      _favoriteMeals = mealList
          .map((mealJson) => Meal.fromJson(jsonDecode(mealJson)))
          .toList();
      notifyListeners();
    }
  }

  // Remove a meal from the favorites list
  Future<void> removeMealFromFavorites(Meal meal) async {
    _favoriteMeals.removeWhere((favMeal) => favMeal.id == meal.id);
    await _saveFavoritesToSharedPreferences();
    notifyListeners();
  }

  // Check if a meal is in the favorites list
  bool isFavorite(Meal meal) {
    return _favoriteMeals.any((favMeal) => favMeal.id == meal.id);
  }
}
