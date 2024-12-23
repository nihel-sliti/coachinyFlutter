// lib/models/cart_item.dart

import 'ingredient.dart';

class CartItem {
  final String name;
  final String imageUrl;
  final int calories;
  final int time;
  final List<Ingredient> ingredients; // Liste d'objets Ingredient
  int quantity;
  final double price;

  CartItem({
    required this.name,
    required this.imageUrl,
    required this.calories,
    required this.time,
    required this.ingredients,
    required this.quantity,
    required this.price,
  });

  // Méthode pour créer un CartItem à partir d'un JSON
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      name: json['name'],
      imageUrl: json['imageUrl'],
      calories: json['calories'],
      time: json['time'],
      ingredients: (json['ingredients'] as List<dynamic>)
          .map((ingredientJson) => Ingredient.fromJson(ingredientJson))
          .toList(),
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
    );
  }

  // Méthode pour convertir un CartItem en JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'calories': calories,
      'time': time,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toJson()).toList(),
      'quantity': quantity,
      'price': price,
    };
  }
}
