import 'package:coachiny/screens/meal_recommendations_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
import '../widgets/progress_card.dart';
import '../widgets/nutrient_pie_chart.dart';
import '../widgets/meal_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadDashboardData();
    });
  }

  Future<void> _loadDashboardData() async {
    await Provider.of<DashboardProvider>(context, listen: false)
        .loadDashboardData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(context);
    final user = dashboardProvider.user;
    final stats = dashboardProvider.stats;
    final recommandations = dashboardProvider.recommandations;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tableau de Bord'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadDashboardData,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  Text(
                    'Bonjour, ${user?.nom} !',
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ProgressCard(
                    title: 'Apport Calorique Aujourd\'hui',
                    currentValue: stats?.apportCalorique ?? 0,
                    goalValue: stats?.objectifCalorique ?? 2000,
                    unit: 'kcal',
                  ),
                  const SizedBox(height: 8.0),
                  // Utilisation d'un SizedBox avec une hauteur définie
                  SizedBox(
                    height: 300.0, // Définissez la hauteur souhaitée
                    child: NutrientPieChart(
                      dataMap: stats?.repartitionMacros ?? {},
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Recommandations du Jour',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MealRecommendationsScreen()),
                      );
                    },
                    child: Text('Voir plus'),
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 250.0,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recommandations.length,
                      itemBuilder: (context, index) {
                        return MealCard(meal: recommandations[index]);
                      },
                    ),
                  ),
                  // Ajoutez d'autres sections si nécessaire
                ],
              ),
            ),
    );
  }
}
