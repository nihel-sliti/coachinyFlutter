// track_weight.dart
import 'package:coachiny/providers/WeightProvider.dart';
import 'package:coachiny/screens/UpdateWeightScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackWeight extends StatelessWidget {
  const TrackWeight({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WeightProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Weight Tracker'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: Consumer<WeightProvider>(
          builder: (context, weightProvider, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Current',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${weightProvider.currentWeight.toStringAsFixed(1)} kg',
                                style: const TextStyle(
                                    fontSize: 36, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${weightProvider.history.first['difference'] > 0 ? '+' : ''}${weightProvider.history.first['difference'].toStringAsFixed(1)} kg',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: weightProvider
                                              .history.first['difference'] >
                                          0
                                      ? Colors.red
                                      : Colors.green,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Starting: ${weightProvider.startingWeight.toStringAsFixed(1)} kg | Goal: ${weightProvider.goalWeight.toStringAsFixed(1)} kg',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => UpdateWeightScreen(),
                              );
                            },
                            child: const Text('Update'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Section Historique
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('History',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {},
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: weightProvider.history.length,
                    itemBuilder: (context, index) {
                      final entry = weightProvider.history[index];
                      return ListTile(
                        title: Text(
                          '${entry['weight'].toStringAsFixed(1)} kg',
                          style: const TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(entry['date']),
                        trailing: Text(
                          '${entry['difference'] > 0 ? '+' : ''}${entry['difference'].toStringAsFixed(1)} kg',
                          style: TextStyle(
                            fontSize: 16,
                            color: entry['difference'] > 0
                                ? Colors.red
                                : Colors.green,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
