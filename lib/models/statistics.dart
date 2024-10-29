class Statistics {
  final int apportCalorique;
  final int objectifCalorique;
  final Map<String, double>
      repartitionMacros; // ex : {'protéines': 30.0, 'glucides': 50.0, 'lipides': 20.0}
  final List<double> progressionPoids; // Historique du poids

  Statistics({
    required this.apportCalorique,
    required this.objectifCalorique,
    required this.repartitionMacros,
    required this.progressionPoids,
  });
}
