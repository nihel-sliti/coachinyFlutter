import 'package:flutter/material.dart';

class ProgressionCard extends StatelessWidget {
  final List<int> data;
  final List<String> days;
  final String period;

  const ProgressionCard({
    Key? key,
    required this.data,
    required this.days,
    required this.period,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Dropdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Progression',
                style: TextStyle(
                  fontSize: 24.0, // Larger font
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButton<String>(
                value: period,
                items: const [
                  DropdownMenuItem(value: 'Weekly', child: Text('Weekly')),
                  DropdownMenuItem(value: 'Monthly', child: Text('Monthly')),
                ],
                onChanged: (value) {
                  // Add logic here
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0),

          // Bar Chart with Y and X Axes
          SizedBox(
            height: 200.0, // Increased chart height
            child: Stack(
              children: [
                // Grid and Axes
                CustomPaint(
                  size: Size(double.infinity, 200),
                  painter: _AxisPainter(),
                ),
                // Bars and Days
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: data.asMap().entries.map((entry) {
                      int index = entry.key;
                      int value = entry.value;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Bar
                          Container(
                            width: 20.0,
                            height: (value / 1000) * 150, // Scale height
                            decoration: BoxDecoration(
                              color: index % 2 == 0
                                  ? const Color(0xFF40B491) // Solid green
                                  : const Color(
                                      0x8040B491), // Transparent green
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          // Day label
                          Text(
                            days[index],
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Axes and Grid Lines
class _AxisPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint axisPaint = Paint()
      ..color = Colors.grey.withOpacity(0.6)
      ..strokeWidth = 1.0;

    Paint gridPaint = Paint()
      ..color = Colors.grey.withOpacity(0.2)
      ..strokeWidth = 1.0;

    // Draw Y-axis and grid lines
    double stepY = size.height / 5; // 5 divisions for Y-axis
    for (int i = 0; i <= 5; i++) {
      double y = size.height - i * stepY;
      canvas.drawLine(Offset(40, y), Offset(size.width, y), gridPaint);

      // Add Y-axis labels
      TextSpan span = TextSpan(
        text: '${i * 200} kcal',
        style: const TextStyle(
          fontSize: 10.0,
          color: Colors.black,
        ),
      );
      TextPainter textPainter = TextPainter(
        text: span,
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(0, y - 6));
    }

    // Draw X-axis
    canvas.drawLine(
        Offset(40, size.height), Offset(size.width, size.height), axisPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
