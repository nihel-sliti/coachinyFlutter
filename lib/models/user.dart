class User {
  final String id;
  final String nom;
  final double poids;
  final double taille;
  final int age;
  final String sexe;
  final String
      activityLevel; // 'sedentary', 'light', 'moderate', 'active', 'very active'
  final String goal; // 'lose_weight' ou 'gain_weight'

  User({
    required this.id,
    required this.nom,
    required this.poids,
    required this.taille,
    required this.age,
    required this.sexe,
    required this.activityLevel,
    required this.goal,
  });
}
