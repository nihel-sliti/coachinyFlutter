// weight_provider.dart
import 'package:flutter/material.dart';

class WeightProvider with ChangeNotifier {
  double currentWeight = 78.5;
  double startingWeight = 80.0;
  double goalWeight = 75.0;

  List<Map<String, dynamic>> history = [
    {'date': 'Dec 22, 2024', 'weight': 78.7, 'difference': 0.2},
    {'date': 'Dec 21, 2024', 'weight': 78.5, 'difference': -0.2},
    {'date': 'Dec 20, 2024', 'weight': 78.8, 'difference': 0.3},
  ];

  void updateWeight(double newWeight) {
    double difference = newWeight - currentWeight;
    history.insert(
      0,
      {'date': 'Today', 'weight': newWeight, 'difference': difference},
    );
    currentWeight = newWeight;
    notifyListeners();
  }
}
