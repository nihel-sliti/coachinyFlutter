// lib/screens/AddFoodScreen.dart
import 'package:coachiny/models/food_iteem.dart';
import 'package:flutter/material.dart';

class AddFoodScreen extends StatefulWidget {
  @override
  _AddFoodScreenState createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  double _calories = 0;
  double _protein = 0;
  double _carbs = 0;
  double _fat = 0;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FoodItem newFood = FoodItem(
        name: _name,
        calories: _calories,
        protein: _protein,
        carbs: _carbs,
        fat: _fat,
      );
      Navigator.pop(context, newFood);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Ajouter un Aliment'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nom de l\'aliment'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer un nom';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Calories par portion'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer les calories';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Veuillez entrer un nombre valide';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _calories = double.parse(value!);
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Protéines (g) par portion'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer les protéines';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Veuillez entrer un nombre valide';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _protein = double.parse(value!);
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Glucides (g) par portion'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer les glucides';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Veuillez entrer un nombre valide';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _carbs = double.parse(value!);
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: 'Lipides (g) par portion'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez entrer les lipides';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Veuillez entrer un nombre valide';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _fat = double.parse(value!);
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _submit,
                    child: Text('Ajouter'),
                  ),
                ],
              ))),
        ));
  }
}
