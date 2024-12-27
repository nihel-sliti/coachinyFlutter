import 'package:coachiny/models/user.dart';
import 'package:coachiny/screens/FoodTrackingScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DietCalculatorScreen extends StatefulWidget {
  const DietCalculatorScreen({super.key});

  @override
  _DietCalculatorScreenState createState() => _DietCalculatorScreenState();
}

class _DietCalculatorScreenState extends State<DietCalculatorScreen> {
  final _formKey = GlobalKey<FormState>();

  // Variables pour stocker les entrées de l'utilisateur
  int? _age;
  double? _weight;
  double? _height;
  String _gender = 'male';
  String _activityLevel = 'sedentary';
  String _goal = 'lose_weight';

  // Variables pour stocker les résultats
  double? _calories;
  double? _protein;
  double? _carbs;
  double? _fat;

  // Référence Firebase Realtime Database
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Méthode pour sauvegarder les résultats dans un chemin fixe
  Future<void> _saveResultsToDatabase(
      double calories, double protein, double carbs, double fat) async {
    try {
      // Chemin fixe dans la base de données
      final DatabaseReference resultRef = _database.child('nihel/diet-result');

      await resultRef.set({
        'calories': calories,
        'protein': protein,
        'carbs': carbs,
        'fat': fat,
        'timestamp': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Résultats sauvegardés avec succès dans Firebase!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la sauvegarde : $e')),
      );
    }
  }

  // Méthode pour calculer les besoins caloriques et en macronutriments
  void _calculateNeeds(User userInfo) {
    double bmr;

    // Calcul du Métabolisme de Base (BMR) selon Harris-Benedict
    if (userInfo.sexe == 'male') {
      bmr = 88.362 +
          (13.397 * userInfo.poids) +
          (4.799 * userInfo.taille) -
          (5.677 * userInfo.age);
    } else {
      bmr = 447.593 +
          (9.247 * userInfo.poids) +
          (3.098 * userInfo.taille) -
          (4.330 * userInfo.age);
    }

    // Facteur d'activité
    double activityFactor;
    switch (userInfo.activityLevel) {
      case 'sedentary':
        activityFactor = 1.2;
        break;
      case 'light':
        activityFactor = 1.375;
        break;
      case 'moderate':
        activityFactor = 1.55;
        break;
      case 'active':
        activityFactor = 1.725;
        break;
      case 'very_active':
        activityFactor = 1.9;
        break;
      default:
        activityFactor = 1.2;
    }

    // Besoins caloriques totaux
    double totalCalories = bmr * activityFactor;

    // Ajustement selon l'objectif
    if (userInfo.goal == 'lose_weight') {
      totalCalories -= 500; // déficit de 500 kcal par jour
    } else if (userInfo.goal == 'gain_weight') {
      totalCalories += 500; // surplus de 500 kcal par jour
    }

    // Répartition des macronutriments
    double protein = (totalCalories * 0.3) / 4; // 30% des calories
    double carbs = (totalCalories * 0.4) / 4; // 40% des calories
    double fat = (totalCalories * 0.3) / 9; // 30% des calories

    setState(() {
      _calories = totalCalories;
      _protein = protein;
      _carbs = carbs;
      _fat = fat;
    });

    // Sauvegarder les résultats dans Realtime Database
    _saveResultsToDatabase(totalCalories, protein, carbs, fat);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculateur Diététique'),
          backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Vous êtes capable d"atteindre vos objectifs santé!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.teal,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Formulaire pour les entrées utilisateur
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Âge
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Âge (ans)',
                        labelStyle: const TextStyle(color: Colors.teal),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre âge';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Veuillez entrer un nombre valide';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _age = int.parse(value!);
                      },
                    ),
                    const SizedBox(height: 10),
                    // Poids
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Poids (kg)',
                        labelStyle: const TextStyle(color: Colors.teal),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre poids';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Veuillez entrer un nombre valide';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _weight = double.parse(value!);
                      },
                    ),
                    const SizedBox(height: 10),
                    // Taille
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Taille (cm)',
                        labelStyle: const TextStyle(color: Colors.teal),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Veuillez entrer votre taille';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Veuillez entrer un nombre valide';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _height = double.parse(value!);
                      },
                    ),
                    const SizedBox(height: 10),
                    // Genre
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Genre',
                        labelStyle: const TextStyle(color: Colors.teal),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      value: _gender,
                      items: const [
                        DropdownMenuItem(
                          value: 'male',
                          child: Text('Homme'),
                        ),
                        DropdownMenuItem(
                          value: 'female',
                          child: Text('Femme'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Niveau d'activité
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Niveau d\'activité',
                        labelStyle: const TextStyle(color: Colors.teal),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      value: _activityLevel,
                      items: const [
                        DropdownMenuItem(
                          value: 'sedentary',
                          child: Text('Sédentaire'),
                        ),
                        DropdownMenuItem(
                          value: 'light',
                          child: Text('Léger'),
                        ),
                        DropdownMenuItem(
                          value: 'moderate',
                          child: Text('Modéré'),
                        ),
                        DropdownMenuItem(
                          value: 'active',
                          child: Text('Actif'),
                        ),
                        DropdownMenuItem(
                          value: 'very_active',
                          child: Text('Très Actif'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _activityLevel = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    // Objectif
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Objectif',
                        labelStyle: const TextStyle(color: Colors.teal),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.teal),
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      value: _goal,
                      items: const [
                        DropdownMenuItem(
                          value: 'lose_weight',
                          child: Text('Perdre du poids'),
                        ),
                        DropdownMenuItem(
                          value: 'gain_weight',
                          child: Text('Gagner du poids'),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _goal = value!;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    // Bouton de calcul
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          User userInfo = User(
                            age: _age!,
                            poids: _weight!,
                            taille: _height!,
                            sexe: _gender,
                            activityLevel: _activityLevel,
                            goal: _goal,
                            id: 'un34',
                            nom: 'nihel',
                          );
                          _calculateNeeds(userInfo);
                        }
                      },
                      child: const Text('Calculer'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Affichage des résultats
              if (_calories != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Vos besoins quotidiens :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Calories : ${_calories!.toStringAsFixed(0)} kcal'),
                    Text('Protéines : ${_protein!.toStringAsFixed(1)} g'),
                    Text('Glucides : ${_carbs!.toStringAsFixed(1)} g'),
                    Text('Lipides : ${_fat!.toStringAsFixed(1)} g'),
                    const SizedBox(height: 20),
                  ],
                ),
            ],
          ),
        ));
  }
}
