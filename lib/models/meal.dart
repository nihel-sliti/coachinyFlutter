class Meal {
  final String id;
  final String nom;
  final String imageUrl;
  final int calories;
  final Map<String, double>
      macronutriments; // ex : {'protéines': 25.0, 'glucides': 50.0, 'lipides': 10.0}

  Meal({
    required this.id,
    required this.nom,
    required this.imageUrl,
    required this.calories,
    required this.macronutriments,
  });
}
