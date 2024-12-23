// update_weight_screen.dart
import 'package:coachiny/providers/WeightProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateWeightScreen extends StatefulWidget {
  @override
  _UpdateWeightScreenState createState() => _UpdateWeightScreenState();
}

class _UpdateWeightScreenState extends State<UpdateWeightScreen> {
  double newWeight = 78.5;

  void _addDecimal() {
    setState(() {
      newWeight += 0.1;
      newWeight = double.parse(newWeight.toStringAsFixed(1));
    });
  }

  void _subtractDecimal() {
    setState(() {
      newWeight -= 0.1;
      if (newWeight < 0) newWeight = 0;
      newWeight = double.parse(newWeight.toStringAsFixed(1));
    });
  }

  @override
  Widget build(BuildContext context) {
    final weightProvider = Provider.of<WeightProvider>(context, listen: false);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Weight',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Current Weight Display
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${newWeight.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
                Text(
                  ' kg',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Numerical Keypad
            GridView.builder(
              shrinkWrap: true,
              itemCount: 12, // 0-9, decimal point, clear
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 2),
              itemBuilder: (context, index) {
                String buttonText;
                VoidCallback onPressed;

                if (index < 10) {
                  buttonText = index.toString();
                  onPressed = () {
                    setState(() {
                      newWeight = newWeight * 10 + index;
                      newWeight = double.parse(newWeight.toStringAsFixed(1));
                    });
                  };
                } else if (index == 10) {
                  buttonText = '.';
                  onPressed = _addDecimal;
                } else {
                  buttonText = 'C';
                  onPressed = () {
                    setState(() {
                      newWeight = 0.0;
                    });
                  };
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
            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    if (newWeight > 0) {
                      weightProvider.updateWeight(newWeight);
                      Navigator.of(context).pop();
                    } else {
                      // Optionally show an error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a valid weight.'),
                        ),
                      );
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
