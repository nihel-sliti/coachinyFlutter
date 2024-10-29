import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final String title;
  final int currentValue;
  final int goalValue;
  final String unit;

  const ProgressCard({
    super.key,
    required this.title,
    required this.currentValue,
    required this.goalValue,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    double progress = currentValue / goalValue;
    progress = progress.clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text('$currentValue / $goalValue $unit'),
            const SizedBox(height: 8.0),
            LinearProgressIndicator(value: progress),
          ],
        ),
      ),
    );
  }
}
