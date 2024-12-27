import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistiques'),
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.6,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 16.0),
                        _buildCalorieMeter(),
                        const SizedBox(height: 24.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: _buildDietJourneyChart(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalorieMeter() {
    return Column(
      children: [
        const Text(
          "Votre score de calories est moyen",
          style: TextStyle(fontSize: 16.0, color: Colors.white70),
        ),
        const SizedBox(height: 16.0),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: 0.7,
                strokeWidth: 12,
                color: Colors.greenAccent,
                backgroundColor: Colors.white24,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.local_fire_department, color: Colors.red, size: 32),
                SizedBox(height: 8.0),
                Text(
                  "1721 Kcal",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "sur 2213 kcal",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMacroStat(
                "Protéines", "78/80g", Icons.emoji_food_beverage, Colors.green),
            _buildMacroStat("Lipides", "45/70g", Icons.grass, Colors.blue),
            _buildMacroStat("Glucides", "55/100g", Icons.cake, Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildMacroStat(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8.0),
        Text(
          label,
          style: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildDietJourneyChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Suivez votre parcours diététique",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          "Calories aujourd'hui : 1721",
          style: TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 16.0),
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      const days = ["D", "L", "M", "M", "J", "V", "S"];
                      return Text(
                        days[value.toInt() % days.length],
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      );
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: [
                    const FlSpot(0, 1000),
                    const FlSpot(1, 1500),
                    const FlSpot(2, 2000),
                    const FlSpot(3, 1800),
                    const FlSpot(4, 2200),
                    const FlSpot(5, 1700),
                    const FlSpot(6, 2000),
                  ],
                  isCurved: true,
                  color: Colors.green,
                  barWidth: 4,
                  belowBarData: BarAreaData(
                    show: true,
                    color: Colors.green.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
