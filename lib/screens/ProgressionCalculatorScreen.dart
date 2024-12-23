import 'package:fl_chart/fl_chart.dart';
import 'package:coachiny/models/program.dart';
import 'package:coachiny/models/session.dart';
import 'package:coachiny/providers/workout_provider.dart';
import 'package:coachiny/screens/add_exercise_screen.dart';
import 'package:coachiny/screens/add_program_screen.dart';
import 'package:coachiny/screens/add_session_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Progressioncalculatorscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ajout d'une barre d'applications avec un bouton pour ajouter un nouveau programme
      appBar: AppBar(
        title: Text('Suivi des Entraînements'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Ouvrir l'écran pour ajouter un nouveau programme
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddProgramScreen()),
              );
            },
          ),
        ],
      ),
      body: Consumer<WorkoutProvider>(
        builder: (context, workoutProvider, child) {
          if (workoutProvider.programs.isEmpty) {
            return Center(
              child: Text(
                'Aucun programme disponible. Ajoutez un programme.',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: workoutProvider.programs.length,
            itemBuilder: (context, index) {
              final program = workoutProvider.programs[index];
              return ProgramCard(program: program);
            },
          );
        },
      ),
    );
  }
}

class ProgramCard extends StatelessWidget {
  final Program program;

  const ProgramCard({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);
    return Card(
      margin: EdgeInsets.all(12.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ExpansionTile(
        title: Text(
          program.name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
            'Total Tonnage : ${program.totalTonnage.toStringAsFixed(1)} kg'),
        children: [
          // Liste des séances
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: program.sessions.length,
            itemBuilder: (context, sessionIndex) {
              final session = program.sessions[sessionIndex];
              return ListTile(
                title: Text(session.date),
                subtitle: Text(
                    'Total Tonnage : ${session.totalTonnage.toStringAsFixed(1)} kg'),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Ajouter un exercice à cette séance
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddExerciseScreen(
                          programName: program.name,
                          sessionDate: session.date,
                        ),
                      ),
                    );
                  },
                ),
                onTap: () {
                  // Afficher les détails de la séance
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SessionDetailScreen(
                          program: program, session: session),
                    ),
                  );
                },
              );
            },
          ),
          // Bouton pour ajouter une nouvelle séance
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text('Ajouter une Séance'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddSessionScreen(programName: program.name),
                  ),
                );
              },
            ),
          ),
          // Affichage de la progression
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              workoutProvider.getProgression(program.name),
              style: TextStyle(
                fontSize: 16,
                color: workoutProvider.getProgression(program.name) ==
                        "Bonne progression !"
                    ? Colors.green
                    : (workoutProvider.getProgression(program.name) ==
                            "Pas de progression cette semaine."
                        ? Colors.orange
                        : Colors.red),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Affichage d'un graphique simple de progression avec fl_chart
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ProgressChart(program: program),
          ),
        ],
      ),
    );
  }
}

class ProgressChart extends StatelessWidget {
  final Program program;

  const ProgressChart({Key? key, required this.program}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroups =
        program.sessions.asMap().entries.map((entry) {
      int index = entry.key;
      Session session = entry.value;
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: session.totalTonnage,
            color: Colors.blue,
            width: 10,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList();

    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: program.sessions
                  .map((s) => s.totalTonnage)
                  .reduce((a, b) => a > b ? a : b) +
              500, // Adjust as needed
          barTouchData: BarTouchData(
            enabled: true,
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: AxisTitles(),
            topTitles: AxisTitles(),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String label = program.sessions[value.toInt()].date
                      .split(' ')[0]; // Simplify label
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    child: Text(label, style: TextStyle(fontSize: 10)),
                  );
                },
                reservedSize: 42,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 1000,
                getTitlesWidget: (value, meta) {
                  return Text('${value.toInt()}',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 10,
                      ));
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: false,
          ),
          barGroups: barGroups,
        ),
      ),
    );
  }
}

class SessionDetailScreen extends StatelessWidget {
  final Program program;
  final Session session;

  const SessionDetailScreen(
      {Key? key, required this.program, required this.session})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(session.date),
      ),
      body: ListView.builder(
        itemCount: session.exercises.length,
        itemBuilder: (context, index) {
          final exercise = session.exercises[index];
          return ListTile(
            title: Text(exercise.name),
            subtitle: Text(
                'Charge : ${exercise.load} kg | Répétitions : ${exercise.reps} | Séries : ${exercise.sets}'),
            trailing: Text('${exercise.totalTonnage} kg'),
          );
        },
      ),
    );
  }
}
