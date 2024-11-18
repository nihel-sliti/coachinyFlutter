import 'package:flutter/material.dart';

class MessageCard extends StatelessWidget {
  final String message;
  final String name;
  final String imageUrl;

  const MessageCard({
    Key? key,
    required this.message,
    required this.name,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF8FD), // Light blue background
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hi $name",
                style: const TextStyle(
                  fontSize: 18.0, // Larger font
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          // Profile Image
          CircleAvatar(
            radius: 28.0, // Slightly larger avatar
            backgroundImage: NetworkImage(imageUrl),
          ),
        ],
      ),
    );
  }
}
