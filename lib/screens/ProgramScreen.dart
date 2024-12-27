import 'package:coachiny/screens/Trackweight.dart';
import 'package:flutter/material.dart';
import 'DietCalculatorScreen.dart';
import 'ProgressionCalculatorScreen.dart';
import 'MeasurementsTrackingScreen.dart';

class ProgramScreen extends StatelessWidget {
  const ProgramScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programmes'),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ProgramOption(
            title: 'Calculateur Diététique',
            icon: Icons.restaurant_menu,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DietCalculatorScreen()),
              );
            },
          ),
          const SizedBox(height: 16),
          ProgramOption(
            title: 'Calculateur de Progression (En Entraînement)',
            icon: Icons.fitness_center,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Progressioncalculatorscreen()),
              );
            },
          ),
          const SizedBox(height: 16),
          ProgramOption(
            title: 'Suivi des Mensurations',
            icon: Icons.track_changes,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MeasurementsTrackingScreen()),
              );
            },
          ),
          const SizedBox(height: 16),
          ProgramOption(
            title: 'Track weight',
            icon: Icons.track_changes_sharp,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrackWeight()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ProgramOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProgramOption({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.teal),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.teal),
        onTap: onTap,
      ),
    );
  }
}
