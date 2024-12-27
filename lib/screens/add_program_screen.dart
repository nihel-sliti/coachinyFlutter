// lib/screens/add_program_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import '../models/program.dart';
import '../models/session.dart';

class AddProgramScreen extends StatefulWidget {
  const AddProgramScreen({super.key});

  @override
  _AddProgramScreenState createState() => _AddProgramScreenState();
}

class _AddProgramScreenState extends State<AddProgramScreen> {
  final _formKey = GlobalKey<FormState>();
  String _programName = '';
  int _durationMonths = 1;

  @override
  Widget build(BuildContext context) {
    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un Programme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Nom du Programme'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _programName = value!;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                decoration: const InputDecoration(labelText: 'Durée (Mois)'),
                value: _durationMonths,
                items: [1, 2, 3, 4, 5, 6].map((month) {
                  return DropdownMenuItem(
                    value: month,
                    child: Text('$month Mois'),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _durationMonths = value!;
                  });
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Créer des séances pour chaque semaine
                    List<Session> sessions = [];
                    for (int month = 1; month <= _durationMonths; month++) {
                      for (int week = 1; week <= 4; week++) {
                        for (int session = 1; session <= 3; session++) {
                          // 3 séances par semaine
                          String date =
                              'Mois $month - Semaine $week Séance $session';
                          sessions.add(Session(date: date, exercises: []));
                        }
                      }
                    }

                    Program newProgram =
                        Program(name: _programName, sessions: sessions);
                    workoutProvider.addProgram(newProgram);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Créer le Programme'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
