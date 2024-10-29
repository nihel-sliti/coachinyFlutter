class Meal {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? type; // e.g., "Petit-déjeuner", "Déjeuner", etc.
  final int? preparationTime; // en minutes
  final int? calories;
  final List<String>? ingredients;
  final String? instructions;
  final Map<String, double>? macronutriments;

  Meal({
    this.id,
    this.name,
    this.imageUrl,
    this.type,
    this.preparationTime,
    this.calories,
    this.ingredients,
    this.instructions,
    this.macronutriments,
  });
}
