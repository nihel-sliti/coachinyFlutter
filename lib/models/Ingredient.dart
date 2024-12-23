// lib/models/ingredient.dart

class Ingredient {
  final String name;
  final double calories;
  final double price;
  final double weight;

  Ingredient({
    required this.name,
    required this.calories,
    required this.price,
    required this.weight,
  });

  // Méthode pour créer un Ingredient à partir d'un JSON
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json['name'] ?? 'Unknown Ingredient',
      calories: (json['calories'] is num) ? json['calories'].toDouble() : 0.0,
      price: (json['price'] is num) ? json['price'].toDouble() : 0.0,
      weight: (json['weight'] is num) ? json['weight'].toDouble() : 0.0,
    );
  }

  // Méthode pour convertir un Ingredient en JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'calories': calories,
      'price': price,
      'weight': weight,
    };
  }
}
