import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class NutrientPieChart extends StatelessWidget {
  final Map<String, double> dataMap;

  const NutrientPieChart({super.key, required this.dataMap});

  @override
  Widget build(BuildContext context) {
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

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Répartition des Macronutriments',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16.0),
            PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: 40.0,
                sectionsSpace: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
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
