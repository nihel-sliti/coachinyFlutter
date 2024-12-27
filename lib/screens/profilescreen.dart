import 'package:coachiny/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>> _fetchDietResult() async {
    final DatabaseReference dietRef =
        FirebaseDatabase.instance.ref('nihel/diet-result');
    final DataSnapshot snapshot = await dietRef.get();

    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> _fetchPurchases(String path) async {
    final DatabaseReference purchasesRef = FirebaseDatabase.instance.ref(path);
    final DataSnapshot snapshot = await purchasesRef.get();

    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    } else {
      return {};
    }
  }

  void _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de la déconnexion : $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil de Nihel'),
        backgroundColor: Colors.teal,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _fetchDietResult(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Erreur lors du chargement des données.'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text('Aucune donnée disponible pour Nihel.'),
              );
            } else {
              final dietResult = snapshot.data!;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 55,
                              backgroundImage: NetworkImage(
                                  'https://media.licdn.com/dms/image/v2/D4E03AQGZBkfAgubkSg/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1682949292176?e=1737590400&v=beta&t=B1yhm9wPd3A-aRIzfAnRrGO5i8lPbS_FQDHDTNOOEBI'),
                            ),
                          ),
                          const SizedBox(height: 16.0),
                          const Text(
                            'NIHEL SLITI',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            '24 ans, Femme',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          const Text(
                            'Poids: 64kg, Taille: 166cm',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.local_fire_department,
                                      color: Colors.red),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'Calories : ${dietResult['calories']?.toStringAsFixed(2) ?? 'Non spécifié'} kcal',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                children: [
                                  const Icon(Icons.emoji_food_beverage,
                                      color: Colors.green),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'Protéines : ${dietResult['protein']?.toStringAsFixed(2) ?? 'Non spécifié'} g',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.cake, color: Colors.orange),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'Glucides : ${dietResult['carbs']?.toStringAsFixed(2) ?? 'Non spécifié'} g',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Row(
                                children: [
                                  const Icon(Icons.grass, color: Colors.blue),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'Lipides : ${dietResult['fat']?.toStringAsFixed(2) ?? 'Non spécifié'} g',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Historique des offres achetées :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    FutureBuilder<Map<String, dynamic>>(
                      future: _fetchPurchases('nihel/offerAchter'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError ||
                            !snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Aucune offre achetée trouvée.'));
                        } else {
                          final offers = snapshot.data!;
                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: offers.entries.map((entry) {
                              final offer = entry.value;
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: ListTile(
                                  leading: const Icon(Icons.card_giftcard,
                                      color: Colors.teal),
                                  title: Text('${entry.key} (Non payé)'),
                                  subtitle:
                                      Text('Durée : ${offer['duration']}'),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Historique des produits achetés :',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    FutureBuilder<Map<String, dynamic>>(
                      future: _fetchPurchases('nihel/produitAchter'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError ||
                            !snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return const Center(
                              child: Text('Aucun produit acheté trouvé.'));
                        } else {
                          final products = snapshot.data!;
                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: products.entries.map((entry) {
                              final product = entry.value;
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: ListTile(
                                  leading: const Icon(Icons.shopping_bag,
                                      color: Colors.orange),
                                  title: Text('${product['name']}'),
                                  subtitle: Text('Prix : ${product['price']}'),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
