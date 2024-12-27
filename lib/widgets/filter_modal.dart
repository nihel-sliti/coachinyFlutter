import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  _FilterModalState createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  late String _selectedMealType;
  late int _maxPrepTime;
  late RangeValues _calorieRange;

  @override
  void initState() {
    super.initState();
    final mealProvider = Provider.of<MealProvider>(context, listen: false);
    _selectedMealType = mealProvider.selectedMealType;
    _maxPrepTime = mealProvider.maxPreparationTime;
    _calorieRange = mealProvider.calorieRange;
  }

  @override
  Widget build(BuildContext context) {
    final mealTypes = [
      'Tous',
      'Petit-déjeuner',
      'Déjeuner',
      'Dîner',
      'Collation'
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Filtres',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Filtre par type de repas
          DropdownButtonFormField<String>(
            value: _selectedMealType,
            items: mealTypes.map((type) {
              return DropdownMenuItem(value: type, child: Text(type));
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedMealType = value!;
              });
            },
            decoration: const InputDecoration(labelText: 'Type de repas'),
          ),
          // Filtre par temps de préparation
          Slider(
            value: _maxPrepTime.toDouble(),
            min: 0,
            max: 120,
            divisions: 24,
            label: '$_maxPrepTime min',
            onChanged: (value) {
              setState(() {
                _maxPrepTime = value.toInt();
              });
            },
          ),
          Text('Temps de préparation maximum: $_maxPrepTime min'),
          // Filtre par calories
          RangeSlider(
            values: _calorieRange,
            min: 0,
            max: 1000,
            divisions: 20,
            labels: RangeLabels(
              '${_calorieRange.start.round()} kcal',
              '${_calorieRange.end.round()} kcal',
            ),
            onChanged: (values) {
              setState(() {
                _calorieRange = values;
              });
            },
          ),
          Text(
              'Calories: ${_calorieRange.start.round()} - ${_calorieRange.end.round()} kcal'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Provider.of<MealProvider>(context, listen: false).updateFilters(
                mealType: _selectedMealType,
                maxPrepTime: _maxPrepTime,
                calorieRange: _calorieRange,
              );
              Navigator.of(context).pop();
            },
            child: const Text('Appliquer les filtres'),
          ),
        ],
      ),
    );
  }
}
