// lib/services/recipe_service.dart

import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<Map<String, dynamic>>> loadRecipes() async {
  // Charger le fichier JSON
  final String response = await rootBundle.loadString('assets/recipes.json');
  // Convertir la chaîne JSON en liste de maps
  final List<dynamic> data = json.decode(response);
  return data.map((e) => e as Map<String, dynamic>).toList();
}
