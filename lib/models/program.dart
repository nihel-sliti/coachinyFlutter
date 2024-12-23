// lib/models/program.dart
import 'session.dart';

class Program {
  String name; // Par exemple : 'Programme 2 Mois'
  List<Session> sessions;

  Program({
    required this.name,
    required this.sessions,
  });

  double get totalTonnage {
    return sessions.fold(0, (sum, session) => sum + session.totalTonnage);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'sessions': sessions.map((s) => s.toMap()).toList(),
    };
  }

  factory Program.fromMap(Map<String, dynamic> map) {
    return Program(
      name: map['name'],
      sessions:
          List<Session>.from(map['sessions']?.map((x) => Session.fromMap(x))),
    );
  }
}
