import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class NutrientPieChart extends StatelessWidget {
  final Map<String, double> dataMap;

  const NutrientPieChart({Key? key, required this.dataMap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataMap.isEmpty) {
      return const Center(child: Text('Aucune donnée disponible'));
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Important pour éviter de prendre tout l'espace
          children: [
            const Text(
              'Répartition des Macronutriments',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            LayoutBuilder(
              builder: (context, constraints) {
                // Définir une taille maximale pour le PieChart
                double size =
                    constraints.maxWidth < 200 ? constraints.maxWidth : 200.0;
                return SizedBox(
                  width: size,
                  height: size,
                  child: PieChart(
                    PieChartData(
                      sections: _buildSections(),
                      centerSpaceRadius: 40.0,
                      sectionsSpace: 2.0,
                      // Ajoutez d'autres configurations si nécessaire
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _buildSections() {
    List<PieChartSectionData> sections = [];
    dataMap.forEach((key, value) {
      sections.add(
        PieChartSectionData(
          value: value,
          color: _getColor(key),
          title: '$key\n${value.toStringAsFixed(1)}%',
          radius: 50.0,
          titleStyle: const TextStyle(fontSize: 14.0, color: Colors.white),
        ),
      );
    });
    return sections;
  }

  Color _getColor(String key) {
    switch (key) {
      case 'Protéines':
        return Colors.blue;
      case 'Glucides':
        return Colors.orange;
      case 'Lipides':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
