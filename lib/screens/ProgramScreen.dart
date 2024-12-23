// lib/screens/ProgramScreen.dart
import 'package:coachiny/screens/Trackweight.dart';
import 'package:flutter/material.dart';
import 'DietCalculatorScreen.dart';
import 'ProgressionCalculatorScreen.dart';
import 'MeasurementsTrackingScreen.dart';

class ProgramScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programmes'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
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
          SizedBox(height: 16),
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
          SizedBox(height: 16),
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

  ProgramOption({
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
      child: ListTile(
        leading: Icon(icon, size: 40, color: Colors.blue),
        title: Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
