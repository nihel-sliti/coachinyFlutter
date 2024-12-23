// lib/screens/DietCalculatorScreen.dart
import 'package:coachiny/models/user.dart';
import 'package:coachiny/screens/FoodTrackingScreen.dart';
import 'package:flutter/material.dart';

class DietCalculatorScreen extends StatefulWidget {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculateur Diététique'),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Formulaire pour les entrées utilisateur
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Âge
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Âge (ans)'),
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
                    SizedBox(height: 10),
                    // Poids
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Poids (kg)'),
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
                    SizedBox(height: 10),
                    // Taille
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Taille (cm)'),
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
                    SizedBox(height: 10),
                    // Genre
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Genre'),
                      value: _gender,
                      items: [
                        DropdownMenuItem(
                          child: Text('Homme'),
                          value: 'male',
                        ),
                        DropdownMenuItem(
                          child: Text('Femme'),
                          value: 'female',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _gender = value!;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // Niveau d'activité
                    DropdownButtonFormField<String>(
                      decoration:
                          InputDecoration(labelText: 'Niveau d\'activité'),
                      value: _activityLevel,
                      items: [
                        DropdownMenuItem(
                          child: Text('Sédentaire'),
                          value: 'sedentary',
                        ),
                        DropdownMenuItem(
                          child: Text('Léger'),
                          value: 'light',
                        ),
                        DropdownMenuItem(
                          child: Text('Modéré'),
                          value: 'moderate',
                        ),
                        DropdownMenuItem(
                          child: Text('Actif'),
                          value: 'active',
                        ),
                        DropdownMenuItem(
                          child: Text('Très Actif'),
                          value: 'very_active',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _activityLevel = value!;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    // Objectif
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Objectif'),
                      value: _goal,
                      items: [
                        DropdownMenuItem(
                          child: Text('Perdre du poids'),
                          value: 'lose_weight',
                        ),
                        DropdownMenuItem(
                          child: Text('Gagner du poids'),
                          value: 'gain_weight',
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _goal = value!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    // Bouton de calcul
                    ElevatedButton(
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
                      child: Text('Calculer'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Affichage des résultats
              if (_calories != null)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Vos besoins quotidiens :',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text('Calories : ${_calories!.toStringAsFixed(0)} kcal'),
                    Text('Protéines : ${_protein!.toStringAsFixed(1)} g'),
                    Text('Glucides : ${_carbs!.toStringAsFixed(1)} g'),
                    Text('Lipides : ${_fat!.toStringAsFixed(1)} g'),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodTrackingScreen(
                                    dailyCalories: _calories!,
                                    dailyProtein: _protein!,
                                    dailyCarbs: _carbs!,
                                    dailyFat: _fat!,
                                  )),
                        );
                      },
                      child: Text('Suivre mes aliments'),
                    ),
                  ],
                ),
            ],
          ),
        ));
  }
}
