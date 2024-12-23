// lib/screens/UpdateMeasurementScreen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/MeasurementsProvider.dart';

class UpdateMeasurementScreen extends StatefulWidget {
  final String measurementName;
  final double currentValue;

  UpdateMeasurementScreen({
    required this.measurementName,
    required this.currentValue,
  });

  @override
  _UpdateMeasurementScreenState createState() =>
      _UpdateMeasurementScreenState();
}

class _UpdateMeasurementScreenState extends State<UpdateMeasurementScreen> {
  late double newValue;

  @override
  void initState() {
    super.initState();
    newValue = widget.currentValue;
  }

  void _inputNumber(int number) {
    setState(() {
      newValue = newValue * 10 + number;
      newValue = double.parse(newValue.toStringAsFixed(1));
    });
  }

  void _addDecimal() {
    setState(() {
      newValue += 0.1;
      newValue = double.parse(newValue.toStringAsFixed(1));
    });
  }

  void _clearValue() {
    setState(() {
      newValue = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final measurementsProvider =
        Provider.of<MeasurementsProvider>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Mettre à Jour ',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Affichage de la valeur actuelle
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${newValue.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' cm',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Clavier numérique
            GridView.builder(
              shrinkWrap: true,
              itemCount: 12, // 0-9, ., C
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) {
                String buttonText;
                VoidCallback onPressed;

                if (index < 10) {
                  buttonText = index.toString();
                  onPressed = () {
                    _inputNumber(index);
                  };
                } else if (index == 10) {
                  buttonText = '.';
                  onPressed = _addDecimal;
                } else {
                  buttonText = 'C';
                  onPressed = _clearValue;
                }

                return InkWell(
                  onTap: onPressed,
                  child: Center(
                    child: Text(
                      buttonText,
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            // Boutons d'action
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Annuler'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    if (newValue > 0) {
                      measurementsProvider.updateMeasurement(
                          widget.measurementName, newValue);
                      Navigator.of(context).pop();
                    } else {
                      // Afficher un message d'erreur
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Veuillez entrer une valeur valide.'),
                        ),
                      );
                    }
                  },
                  child: Text('Sauvegarder'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
