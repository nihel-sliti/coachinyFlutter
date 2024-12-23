// lib/models/consumed_food.dart
import 'package:coachiny/models/food_iteem.dart';

class ConsumedFood {
  final FoodItem food;
  final int quantity; // nombre de portions

  ConsumedFood({
    required this.food,
    required this.quantity,
  });
}
