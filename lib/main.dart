import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/dashboard_provider.dart';
import './screens/dashboard_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Application Repas Sains',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DashboardScreen(),
    );
  }
}
