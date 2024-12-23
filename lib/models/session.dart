// lib/models/session.dart
import 'exercise.dart';

class Session {
  String date; // Format : 'Semaine 1 Séance 1'
  List<Exercise> exercises;

  Session({
    required this.date,
    required this.exercises,
  });

  double get totalTonnage {
    return exercises.fold(0, (sum, exercise) => sum + exercise.totalTonnage);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'exercises': exercises.map((e) => e.toMap()).toList(),
    };
  }

  factory Session.fromMap(Map<String, dynamic> map) {
    return Session(
      date: map['date'],
      exercises: List<Exercise>.from(
          map['exercises']?.map((x) => Exercise.fromMap(x))),
    );
  }
}
