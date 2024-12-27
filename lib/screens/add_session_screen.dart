// lib/screens/add_session_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import '../models/session.dart';

class AddSessionScreen extends StatefulWidget {
  final String programName;

  const AddSessionScreen({super.key, required this.programName});

  @override
  _AddSessionScreenState createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  String _sessionDate = '';

  @override
  Widget build(BuildContext context) {
    final workoutProvider =
        Provider.of<WorkoutProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter une Séance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Date de la Séance'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une date';
                  }
                  return null;
                },
                onSaved: (value) {
                  _sessionDate = value!;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    Session newSession =
                        Session(date: _sessionDate, exercises: []);
                    workoutProvider.addSession(widget.programName, newSession);
                    Navigator.of(context).pop();
                  }
                },
                child: Text('Créer la Séance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
