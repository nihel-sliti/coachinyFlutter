class Exercise {
  String name;
  double load; // En kg
  int reps;
  int sets;

  Exercise({
    required this.name,
    required this.load,
    required this.reps,
    required this.sets,
  });

  double get totalTonnage => load * reps * sets;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'load': load,
      'reps': reps,
      'sets': sets,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'],
      load: map['load'],
      reps: map['reps'],
      sets: map['sets'],
    );
  }
}
