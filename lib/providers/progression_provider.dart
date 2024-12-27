// lib/providers/progression_provider.dart
import 'package:coachiny/models/exercise.dart';
import 'package:coachiny/models/program.dart';
import 'package:coachiny/models/session.dart';
import 'package:flutter/material.dart';

class ProgressionProvider with ChangeNotifier {
  final List<Program> _programs = [];

  List<Program> get programs => _programs;

  void addProgram(Program program) {
    _programs.add(program);
    notifyListeners();
  }

  void removeProgram(Program program) {
    _programs.remove(program);
    notifyListeners();
  }

  void addSessionToProgram(Program program, Session session) {
    program.sessions.add(session);
    notifyListeners();
  }

  void removeSessionFromProgram(Program program, Session session) {
    program.sessions.remove(session);
    notifyListeners();
  }

  void addExerciseToSession(Session session, Exercise exercise) {
    session.exercises.add(exercise);
    notifyListeners();
  }

  void removeExerciseFromSession(Session session, Exercise exercise) {
    session.exercises.remove(exercise);
    notifyListeners();
  }
}
