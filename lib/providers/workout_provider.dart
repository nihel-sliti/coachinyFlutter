// lib/providers/workout_provider.dart
import 'package:flutter/material.dart';
import '../models/exercise.dart';
import '../models/session.dart';
import '../models/program.dart';

class WorkoutProvider with ChangeNotifier {
  List<Program> programs = [];

  // Ajoute un nouveau programme
  void addProgram(Program program) {
    programs.add(program);
    notifyListeners();
  }

  // Ajoute une nouvelle séance à un programme
  void addSession(String programName, Session session) {
    final program = programs.firstWhere((p) => p.name == programName);
    program.sessions.add(session);
    notifyListeners();
  }

  // Ajoute un exercice à une séance spécifique
  void addExercise(String programName, String sessionDate, Exercise exercise) {
    final program = programs.firstWhere((p) => p.name == programName);
    final session = program.sessions.firstWhere((s) => s.date == sessionDate);
    session.exercises.add(exercise);
    notifyListeners();
  }

  // Met à jour un exercice
  void updateExercise(String programName, String sessionDate, int exerciseIndex,
      Exercise newExercise) {
    final program = programs.firstWhere((p) => p.name == programName);
    final session = program.sessions.firstWhere((s) => s.date == sessionDate);
    session.exercises[exerciseIndex] = newExercise;
    notifyListeners();
  }

  // Calcul de la progression : Compare le tonnage total des séances précédentes
  String getProgression(String programName) {
    final program = programs.firstWhere((p) => p.name == programName);
    if (program.sessions.length < 2) {
      return "Pas assez de données pour la progression.";
    }
    final lastSession =
        program.sessions[program.sessions.length - 1].totalTonnage;
    final previousSession =
        program.sessions[program.sessions.length - 2].totalTonnage;
    if (lastSession > previousSession) {
      return "Bonne progression !";
    } else if (lastSession == previousSession) {
      return "Pas de progression cette semaine.";
    } else {
      return "Révision nécessaire de votre programme.";
    }
  }
}
