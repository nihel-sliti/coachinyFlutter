// lib/screens/add_exercise_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import '../models/exercise.dart';

class AddExerciseScreen extends StatefulWidget {
  final String programName;
  final String sessionDate;
  final Exercise? existingExercise; // Exercice existant pour l'édition
  final int? exerciseIndex; // Index de l'exercice à éditer

  const AddExerciseScreen({
    super.key,
    required this.programName,
    required this.sessionDate,
    this.existingExercise,
    this.exerciseIndex,
  });

  @override
  _AddOrEditExerciseScreenState createState() =>
      _AddOrEditExerciseScreenState();
}

class _AddOrEditExerciseScreenState extends State<AddExerciseScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _exerciseName;
  late double _load;
  late int _reps;
  late int _sets;

  @override
  void initState() {
    super.initState();
    if (widget.existingExercise != null) {
      _exerciseName = widget.existingExercise!.name;
      _load = widget.existingExercise!.load;
      _reps = widget.existingExercise!.reps;
      _sets = widget.existingExercise!.sets;
    } else {
      _exerciseName = '';
      _load = 0.0;
      _reps = 0;
      _sets = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingExercise == null
            ? 'Ajouter un Exercice'
            : 'Éditer l\'Exercice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _exerciseName,
                decoration:
                    const InputDecoration(labelText: 'Nom de l\'Exercice'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _exerciseName = value!;
                },
              ),
              TextFormField(
                initialValue: _load != 0.0 ? _load.toStringAsFixed(1) : '',
                decoration: const InputDecoration(labelText: 'Charge (kg)'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une charge';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _load = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _reps != 0 ? _reps.toString() : '',
                decoration: const InputDecoration(labelText: 'Répétitions'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nombre de répétitions';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _reps = int.parse(value!);
                },
              ),
              TextFormField(
                initialValue: _sets != 0 ? _sets.toString() : '',
                decoration: const InputDecoration(labelText: 'Séries'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le nombre de séries';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _sets = int.parse(value!);
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Exercise exercise = Exercise(
                      name: _exerciseName,
                      load: _load,
                      reps: _reps,
                      sets: _sets,
                    );

                    if (widget.existingExercise == null) {
                      // Ajouter un nouvel exercice
                      workoutProvider.addExercise(
                          widget.programName, widget.sessionDate, exercise);
                    } else {
                      // Éditer l'exercice existant
                      if (widget.exerciseIndex != null) {
                        workoutProvider.updateExercise(
                            widget.programName,
                            widget.sessionDate,
                            widget.exerciseIndex!,
                            exercise);
                      }
                    }

                    Navigator.of(context).pop();
                  }
                },
                child: Text(widget.existingExercise == null
                    ? 'Ajouter l\'Exercice'
                    : 'Enregistrer les Modifications'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
