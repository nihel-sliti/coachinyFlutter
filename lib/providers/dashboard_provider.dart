import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/meal.dart';
import '../models/statistics.dart';

class DashboardProvider with ChangeNotifier {
  User? _user;
  Statistics? _stats;
  List<Meal> _recommandations = [];

  User? get user => _user;
  Statistics? get stats => _stats;
  List<Meal> get recommandations => _recommandations;

  Future<void> fetchUserData() async {
    // Simuler la récupération des données utilisateur
    _user = User(
      id: 'u123',
      nom: 'Alexandre',
      poids: 85.0,
      taille: 175.0,
      age: 40,
      sexe: 'Homme',
    );
    notifyListeners();
  }

  Future<void> fetchStatistics() async {
    // Simuler la récupération des statistiques
    _stats = Statistics(
      apportCalorique: 1500,
      objectifCalorique: 2000,
      repartitionMacros: {
        'Protéines': 30.0,
        'Glucides': 50.0,
        'Lipides': 20.0,
      },
      progressionPoids: [85.0, 84.5, 84.0, 83.5],
    );
    notifyListeners();
  }

  Future<void> fetchRecommandations() async {
    // Simuler la récupération des recommandations de repas
    _recommandations = [
      Meal(
        id: 'm1',
        name: 'Salade de Quinoa',
        imageUrl: 'assets/images/Salade_de_Quinoa.png', // URL valide
        calories: 400,
        macronutriments: {'Protéines': 15.0, 'Glucides': 60.0, 'Lipides': 10.0},
      ),
      Meal(
        id: 'm2',
        name: 'Poulet Grillé',
        imageUrl: 'assets/images/Poulet_grille.png', // URL valide
        calories: 500,
        macronutriments: {'Protéines': 40.0, 'Glucides': 30.0, 'Lipides': 15.0},
      ),
    ];

    notifyListeners();
  }

  Future<void> loadDashboardData() async {
    await Future.wait([
      fetchUserData(),
      fetchStatistics(),
      fetchRecommandations(),
    ]);
  }
}
