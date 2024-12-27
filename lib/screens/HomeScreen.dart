import 'package:coachiny/screens/OffersScreen.dart';
import 'package:coachiny/screens/ProgramScreen.dart';
import 'package:coachiny/screens/dashboard_screen.dart';
import 'package:coachiny/screens/meal_detail_screen.dart';
import 'package:coachiny/screens/meal_recommendations_screen.dart';
import 'package:coachiny/screens/productScreen.dart';
import 'package:coachiny/screens/profilescreen.dart';
import 'package:coachiny/screens/statistic_screen.dart';
import 'package:coachiny/widgets/progression_card.dart';
import 'package:coachiny/widgets/statistics_card.dart';
import 'package:flutter/material.dart';
import 'package:coachiny/widgets/HorizontalItem.dart'; // Vérifiez que le fichier existe
import 'package:coachiny/widgets/message_card.dart'; // Vérifiez que le fichier existe

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const Center(child: Text('Home Screen Content')),
    const Center(child: Text('Location Screen Content')),
    const Center(child: Text('Messages Screen Content')),
    const Center(child: Text('Favorites Screen Content')),
    const Center(child: Text('Profile Screen Content')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8FD),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()),
                );
              },
              child: const MessageCard(
                name: 'Nihel',
                message: 'Good Morning',
                imageUrl:
                    'https://media.licdn.com/dms/image/v2/D4E03AQGZBkfAgubkSg/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1682949292176?e=1737590400&v=beta&t=B1yhm9wPd3A-aRIzfAnRrGO5i8lPbS_FQDHDTNOOEBI',
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 120.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  HorizontalItem(
                    imageUrl:
                        'https://www.legalplace.fr/wp-content/uploads/2019/05/13.05-Contenu-Web-Devenir-coach-sportif-1.jpg',
                    label: 'Offer',
                    destination: OffersScreen(),
                  ),
                  HorizontalItem(
                    imageUrl:
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFVzY_5ptqcdVAcy4kH2xqmS8uc1BdLa7Xqg&s',
                    label: 'Program',
                    destination: ProgramScreen(),
                  ),
                  HorizontalItem(
                    imageUrl:
                        'https://www.nutrimove.fr/images/formation-produits-dietetiques-sportifs.jpg',
                    label: 'Product',
                    destination: ProductScreen(),
                  ),
                  const HorizontalItem(
                    imageUrl:
                        'https://www.mangezplus.com/wp-content/uploads/2020/02/wok-de-poulet-recette-healthy-et-rapide.jpg',
                    label: 'Recipe',
                    destination: DashboardScreen(),
                  ),
                ],
              ),
            ),
            const StatisticsCard(
              score: 660,
              description: 'Your Calories Score is average',
              targetScreen: StatisticsScreen(),
            ),
            const ProgressionCard(
              data: [200, 400, 800, 600, 300, 900],
              days: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'],
              period: 'Weekly',
            )
          ],
        ),
      ),
    );
  }
}
