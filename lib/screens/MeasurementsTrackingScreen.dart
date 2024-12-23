// lib/screens/MeasurementsTrackingScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/MeasurementsProvider.dart';
import 'UpdateMeasurementScreen.dart';

class MeasurementsTrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Suivi des Mensurations'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Ouvrir un dialogue pour ajouter une nouvelle mensuration
              showDialog(
                context: context,
                builder: (context) => AddMeasurementDialog(),
              );
            },
          ),
        ],
      ),
      body: Consumer<MeasurementsProvider>(
        builder: (context, measurementsProvider, child) {
          return ListView.builder(
            itemCount: measurementsProvider.measurements.length,
            itemBuilder: (context, index) {
              final measurement = measurementsProvider.measurements[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                child: ListTile(
                  title: Text(
                    measurement.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Actuel: ${measurement.currentValue.toStringAsFixed(1)} cm | Objectif: ${measurement.goalValue.toStringAsFixed(1)} cm',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      // Ouvrir le dialogue de mise à jour de la mensuration
                      showDialog(
                        context: context,
                        builder: (context) => UpdateMeasurementScreen(
                          measurementName: measurement.name,
                          currentValue: measurement.currentValue,
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    // Optionnel : Afficher l'historique ou plus de détails
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MeasurementDetailScreen(measurement: measurement),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AddMeasurementDialog extends StatefulWidget {
  @override
  _AddMeasurementDialogState createState() => _AddMeasurementDialogState();
}

class _AddMeasurementDialogState extends State<AddMeasurementDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _currentValue = 0.0;
  double _goalValue = 0.0;

  @override
  Widget build(BuildContext context) {
    final measurementsProvider =
        Provider.of<MeasurementsProvider>(context, listen: false);

    return AlertDialog(
      title: Text('Ajouter une Mensuration'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                decoration:
                    InputDecoration(labelText: 'Nom (ex. Tour de Bras)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un nom';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Valeur Actuelle (cm)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une valeur';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _currentValue = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Objectif (cm)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une valeur';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un nombre valide';
                  }
                  return null;
                },
                onSaved: (value) {
                  _goalValue = double.parse(value!);
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text('Annuler'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('Ajouter'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              measurementsProvider.measurements.add(
                Measurement(
                  name: _name,
                  currentValue: _currentValue,
                  goalValue: _goalValue,
                  history: [
                    {
                      'date': 'Today',
                      'value': _currentValue,
                      'difference': 0.0
                    },
                  ],
                ),
              );
              measurementsProvider.notifyListeners();
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

class MeasurementDetailScreen extends StatelessWidget {
  final Measurement measurement;

  MeasurementDetailScreen({required this.measurement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ${measurement.name}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '${measurement.name}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Valeur Actuelle: ${measurement.currentValue.toStringAsFixed(1)} cm',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Objectif: ${measurement.goalValue.toStringAsFixed(1)} cm',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: measurement.history.length,
                itemBuilder: (context, index) {
                  final entry = measurement.history[index];
                  return ListTile(
                    title: Text('${entry['value'].toStringAsFixed(1)} cm'),
                    subtitle: Text(entry['date']),
                    trailing: Text(
                      '${entry['difference'] > 0 ? '+' : ''}${entry['difference'].toStringAsFixed(1)} cm',
                      style: TextStyle(
                        color:
                            entry['difference'] > 0 ? Colors.red : Colors.green,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}