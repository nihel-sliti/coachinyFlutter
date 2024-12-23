// lib/models/food_item.dart
class FoodItem {
  final String name;
  final double calories; // par portion
  final double protein; // en grammes
  final double carbs; // en grammes
  final double fat; // en grammes

  FoodItem({
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
  });
}
