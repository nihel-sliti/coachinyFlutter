import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
        title: const Text(
          "Statistics",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              'https://media.licdn.com/dms/image/v2/D4E03AQGZBkfAgubkSg/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1682949292176?e=1737590400&v=beta&t=B1yhm9wPd3A-aRIzfAnRrGO5i8lPbS_FQDHDTNOOEBI',
            ), // Replace with your image
            radius: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            // Calorie Meter Section
            _buildCalorieMeter(),
            const SizedBox(height: 24.0),
            // Diet Journey Section
            _buildDietJourneyChart(),
          ],
        ),
      ),
    );
  }

  // Calorie Meter Widget
  Widget _buildCalorieMeter() {
    return Column(
      children: [
        const Text(
          "Your Calories Score is average",
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
        const SizedBox(height: 16.0),
        Stack(
          alignment: Alignment.center,
          children: [
            // Gauge background
            SizedBox(
              width: 200,
              height: 200,
              child: CircularProgressIndicator(
                value: 0.7, // Change this to dynamically update progress
                strokeWidth: 12,
                color: Colors.green,
                backgroundColor: Colors.grey[300],
              ),
            ),
            // Calorie Count
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.local_fire_department, color: Colors.red, size: 32),
                SizedBox(height: 8.0),
                Text(
                  "1721 Kcal",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "of 2213 kcal",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMacroStat("Protein", "78/80g"),
            _buildMacroStat("Fats", "45/70g"),
            _buildMacroStat("Carbs", "55/100g"),
          ],
        ),
      ],
    );
  }

  // Macro Stat Widget (e.g., Protein, Fats, Carbs)
  Widget _buildMacroStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8.0),
        Text(
          value,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }

  // Diet Journey Chart Widget
  Widget _buildDietJourneyChart() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF40B491),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Track your diet journey",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8.0),
          const Text(
            "Today Calorie: 1721",
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
          const SizedBox(height: 16.0),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = ["S", "M", "T", "W", "T", "F", "S"];
                        return Text(
                          days[value.toInt() % days.length],
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: false,
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 1000),
                      FlSpot(1, 1500),
                      FlSpot(2, 2000),
                      FlSpot(3, 1800),
                      FlSpot(4, 2200),
                      FlSpot(5, 1700),
                      FlSpot(6, 2000),
                    ],
                    isCurved: true,
                    color: Colors.white,
                    barWidth: 4,
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
