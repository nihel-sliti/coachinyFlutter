// lib/screens/add_session_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import '../models/session.dart';

class AddSessionScreen extends StatefulWidget {
  final String programName;

  const AddSessionScreen({Key? key, required this.programName})
      : super(key: key);

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
        title: Text('Ajouter une Séance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Date de la Séance'),
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
              SizedBox(height: 24),
              ElevatedButton(
                child: Text('Créer la Séance'),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
