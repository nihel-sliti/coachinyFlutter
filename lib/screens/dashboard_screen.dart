import 'package:coachiny/screens/meal_recommendations_screen.dart';
import 'package:coachiny/widgets/TodayRecipeWidget.dart';
import 'package:coachiny/widgets/message_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/dashboard_provider.dart';
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
      backgroundColor: const Color(0xFFEFF8FD),
      appBar: AppBar(
        title: const Text('Today\'s Recipe'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://media.licdn.com/dms/image/v2/D4E03AQGZBkfAgubkSg/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1682949292176?e=1737590400&v=beta&t=B1yhm9wPd3A-aRIzfAnRrGO5i8lPbS_FQDHDTNOOEBI',
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadDashboardData,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  /* const SizedBox(height: 16.0),
                  ProgressCard(
                    title: 'Apport Calorique Aujourd\'hui',
                    currentValue: stats?.apportCalorique ?? 0,
                    goalValue: stats?.objectifCalorique ?? 2000,
                    unit: 'kcal',
                  ),*/
                  const SizedBox(height: 8.0),
                  // Utilisation d'un SizedBox avec une hauteur définie
                  SizedBox(
                    height:
                        450.0, // Définissez la hauteur souhaitée si nécessaire
                    child: TodayRecipeWidget(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Espace entre les éléments
                    children: [
                      const Text(
                        'Recommanded',
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
                                builder: (context) =>
                                    MealRecommendationsScreen()),
                          );
                        },
                        child: const Text('Voir plus'),
                      ),
                    ],
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
