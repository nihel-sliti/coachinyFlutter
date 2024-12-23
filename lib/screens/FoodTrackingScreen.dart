// lib/screens/FoodTrackingScreen.dart
import 'package:coachiny/models/ConsumedFood.dart';
import 'package:coachiny/models/food_iteem.dart';
import 'package:coachiny/screens/AddFoodScreen.dart';
import 'package:flutter/material.dart';

class FoodTrackingScreen extends StatefulWidget {
  final double dailyCalories;
  final double dailyProtein;
  final double dailyCarbs;
  final double dailyFat;

  FoodTrackingScreen({
    required this.dailyCalories,
    required this.dailyProtein,
    required this.dailyCarbs,
    required this.dailyFat,
  });

  @override
  _FoodTrackingScreenState createState() => _FoodTrackingScreenState();
}

class _FoodTrackingScreenState extends State<FoodTrackingScreen> {
  List<ConsumedFood> _consumedFoods = [];
  List<FoodItem> _availableFoods = [
    // Liste de base de quelques aliments
    FoodItem(
      name: 'Poulet Grillé',
      calories: 165,
      protein: 31,
      carbs: 0,
      fat: 3.6,
    ),
    FoodItem(
      name: 'Riz Blanc',
      calories: 130,
      protein: 2.4,
      carbs: 28,
      fat: 0.3,
    ),
    // Ajoutez plus d'aliments ici
  ];

  // Méthode pour ajouter un aliment consommé
  void _addConsumedFood(FoodItem food, int quantity) {
    setState(() {
      _consumedFoods.add(ConsumedFood(food: food, quantity: quantity));
    });
  }

  // Méthode pour supprimer un aliment consommé
  void _removeConsumedFood(int index) {
    setState(() {
      _consumedFoods.removeAt(index);
    });
  }

  // Calcul des totaux consommés
  double get _totalCalories {
    return _consumedFoods.fold(
        0, (sum, item) => sum + item.food.calories * item.quantity);
  }

  double get _totalProtein {
    return _consumedFoods.fold(
        0, (sum, item) => sum + item.food.protein * item.quantity);
  }

  double get _totalCarbs {
    return _consumedFoods.fold(
        0, (sum, item) => sum + item.food.carbs * item.quantity);
  }

  double get _totalFat {
    return _consumedFoods.fold(
        0, (sum, item) => sum + item.food.fat * item.quantity);
  }

  // Naviguer vers l'écran d'ajout d'aliment
  void _navigateToAddFood() async {
    final newFood = await Navigator.push<FoodItem>(
      context,
      MaterialPageRoute(builder: (context) => AddFoodScreen()),
    );

    if (newFood != null) {
      setState(() {
        _availableFoods.add(newFood);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Suivi des Aliments'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: _navigateToAddFood,
              tooltip: 'Ajouter un nouvel aliment',
            ),
          ],
        ),
        body: Column(
          children: [
            // Liste des aliments consommés
            Expanded(
              child: ListView.builder(
                itemCount: _consumedFoods.length,
                itemBuilder: (context, index) {
                  final consumedFood = _consumedFoods[index];
                  return ListTile(
                    leading: Icon(Icons.food_bank),
                    title: Text(consumedFood.food.name),
                    subtitle: Text('Quantité : ${consumedFood.quantity}'),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removeConsumedFood(index);
                      },
                    ),
                  );
                },
              ),
            ),
            Divider(),
            // Résumé des apports
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Résumé des Apports :',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Calories consommées : ${_totalCalories.toStringAsFixed(0)} / ${widget.dailyCalories.toStringAsFixed(0)} kcal'),
                  Text(
                      'Protéines consommées : ${_totalProtein.toStringAsFixed(1)} g / ${widget.dailyProtein.toStringAsFixed(1)} g'),
                  Text(
                      'Glucides consommés : ${_totalCarbs.toStringAsFixed(1)} g / ${widget.dailyCarbs.toStringAsFixed(1)} g'),
                  Text(
                      'Lipides consommés : ${_totalFat.toStringAsFixed(1)} g / ${widget.dailyFat.toStringAsFixed(1)} g'),
                ],
              ),
            ),
          ],
        ));
  }
}
