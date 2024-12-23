// lib/providers/MeasurementsProvider.dart
import 'package:flutter/material.dart';

class Measurement {
  String name;
  double currentValue;
  double goalValue;
  List<Map<String, dynamic>> history;

  Measurement({
    required this.name,
    required this.currentValue,
    required this.goalValue,
    required this.history,
  });

  void updateValue(double newValue) {
    double difference = newValue - currentValue;
    history.insert(
      0,
      {
        'date': 'Today',
        'value': newValue,
        'difference': difference,
      },
    );
    currentValue = newValue;
  }
}

class MeasurementsProvider with ChangeNotifier {
  // Liste des différentes mensurations à suivre
  List<Measurement> measurements = [
    Measurement(
      name: 'Tour de Taille',
      currentValue: 85.0,
      goalValue: 75.0,
      history: [
        {'date': 'Dec 22, 2024', 'value': 85.0, 'difference': 0.0},
        {'date': 'Dec 21, 2024', 'value': 85.5, 'difference': 0.5},
        {'date': 'Dec 20, 2024', 'value': 86.0, 'difference': 0.5},
      ],
    ),
    Measurement(
      name: 'Tour de Poitrine',
      currentValue: 100.0,
      goalValue: 95.0,
      history: [
        {'date': 'Dec 22, 2024', 'value': 100.0, 'difference': 0.0},
        {'date': 'Dec 21, 2024', 'value': 100.5, 'difference': 0.5},
        {'date': 'Dec 20, 2024', 'value': 101.0, 'difference': 0.5},
      ],
    ),
    Measurement(
      name: 'Tour de Bras',
      currentValue: 35.0,
      goalValue: 32.0,
      history: [
        {'date': 'Dec 22, 2024', 'value': 35.0, 'difference': 0.0},
        {'date': 'Dec 21, 2024', 'value': 35.3, 'difference': 0.3},
        {'date': 'Dec 20, 2024', 'value': 35.6, 'difference': 0.3},
      ],
    ),
    // Ajoutez d'autres mensurations si nécessaire
  ];

  void updateMeasurement(String name, double newValue) {
    final measurement = measurements.firstWhere((m) => m.name == name);
    measurement.updateValue(newValue);
    notifyListeners();
  }
}
