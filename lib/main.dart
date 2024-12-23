// lib/main.dart
import 'package:coachiny/providers/FavoriteProvider.dart';
import 'package:coachiny/providers/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/dashboard_provider.dart';
import 'providers/meal_provider.dart';
import 'providers/WeightProvider.dart';
import 'providers/MeasurementsProvider.dart';
import 'screens/HomeScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
        ChangeNotifierProvider(create: (_) => MealProvider()),
        ChangeNotifierProvider(create: (_) => WeightProvider()),
        ChangeNotifierProvider(create: (_) => MeasurementsProvider()),
        ChangeNotifierProvider(create: (_) => WorkoutProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Application Repas Sains',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomeScreen(),
    );
  }
}
