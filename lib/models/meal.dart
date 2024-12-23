// lib/models/meal.dart

import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'ingredient.dart';

class Meal {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? type; // e.g., "Petit-déjeuner", "Déjeuner", etc.
  final int? preparationTime; // en minutes
  final int? calories;
  final double? price; // Prix total de la recette
  final List<Ingredient>? ingredients; // Liste d'objets Ingredient
  final String? instructions;
  final Map<String, double>? macronutriments;
  final String? description;
  bool isLiked; // État du "like"

  Meal({
    this.id,
    this.name,
    this.imageUrl,
    this.type,
    this.preparationTime,
    this.calories,
    this.price,
    this.ingredients,
    this.instructions,
    this.macronutriments,
    this.description,
    this.isLiked = false, // Par défaut non aimé
  });

  // Méthode pour créer une instance Meal à partir d'un JSON
  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
      id: json['id'],
      name: json['Nom_de_la_Recette'],
      imageUrl: json['imageUrl'],
      type: json['categories'],
      preparationTime: json['Temps_de_Preparation_min'],
      calories: json['Calories'],
      price: (json['price'] is num) ? json['price'].toDouble() : 0.0,
      ingredients: _parseIngredients(json['Ingre_dients']),
      instructions: json['Instructions'],
      macronutriments: {
        'proteins': (json['Proteines_g'] is num)
            ? (json['Proteines_g'] as num).toDouble()
            : 0.0,
        'fat': (json['Lipides_g'] is num)
            ? (json['Lipides_g'] as num).toDouble()
            : 0.0,
        'carbs': (json['Glucides_g'] is num)
            ? (json['Glucides_g'] as num).toDouble()
            : 0.0,
      },
      description: json['Description'],
      isLiked: json['Like'] == 1, // Si "Like" est 1, il est aimé
    );
  }

  // Méthode pour parser les ingrédients
  static List<Ingredient> _parseIngredients(dynamic ingredientsData) {
    if (ingredientsData is List) {
      return ingredientsData
          .map((ingredientJson) => Ingredient.fromJson(ingredientJson))
          .toList();
    } else {
      return [];
    }
  }

  // Méthode pour convertir une instance Meal en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Nom_de_la_Recette': name,
      'imageUrl': imageUrl,
      'categories': type,
      'Temps_de_Preparation_min': preparationTime,
      'Calories': calories,
      'price': price,
      'Ingre_dients':
          ingredients?.map((ingredient) => ingredient.toJson()).toList(),
      'Instructions': instructions,
      'Proteines_g': macronutriments?['proteins'],
      'Lipides_g': macronutriments?['fat'],
      'Glucides_g': macronutriments?['carbs'],
      'Description': description,
      'Like': isLiked ? 1 : 0, // Convertit l'état "like" en 1 ou 0
    };
  }

  // Méthode pour récupérer le fichier local
  static Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final path = directory.path;
    return File('$path/recipes.json');
  }

  // Sauvegarder la liste des recettes dans un fichier
  static Future<void> saveRecipes(List<Meal> meals) async {
    final List<Map<String, dynamic>> jsonMeals =
        meals.map((meal) => meal.toJson()).toList();
    final String updatedJson = json.encode(jsonMeals);
    final file = await _localFile;
    await file.writeAsString(updatedJson);
  }

  // Charger la liste des recettes depuis un fichier
  static Future<List<Meal>> loadRecipes() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final String jsonData = await file.readAsString();
        final List<dynamic> jsonList = json.decode(jsonData);
        return jsonList.map((json) => Meal.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      // Vous pouvez logger l'erreur ou la gérer autrement
      print('Erreur lors du chargement des recettes: $e');
      return [];
    }
  }
}
