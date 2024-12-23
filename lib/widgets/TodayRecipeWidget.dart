import 'package:flutter/material.dart';

class TodayRecipeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFF8FD),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white, // Fond global de la barre
                  borderRadius: BorderRadius.circular(25),
                  // Coins arrondis
                ),
                margin: EdgeInsets.all(8.0),
                child: TabBar(
                  tabs: const [
                    Tab(text: '  Breakfast '),
                    Tab(text: '  Lunch  '),
                    Tab(text: '  Dinner '),
                  ],
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicator: BoxDecoration(
                    color: Colors.white30, // Fond pour l'onglet sélectionné
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Recipe content for each tab
              Expanded(
                child: TabBarView(
                  children: [
                    // Recipe for Breakfast
                    RecipeCard(
                      recipeTitle: 'Salad with eggs',
                      imageAsset: 'assets/images/Pastawithveg.jpg',
                      calories: '294 kcal - 100g',
                      protein: 15,
                      fats: 10,
                      carbs: 8,
                    ),
                    // Recipe for Lunch
                    RecipeCard(
                      recipeTitle: 'Grilled Chicken',
                      imageAsset: 'assets/images/Pastawithveg.jpg',
                      calories: '420 kcal - 150g',
                      protein: 40,
                      fats: 15,
                      carbs: 10,
                    ),
                    // Recipe for Dinner
                    RecipeCard(
                      recipeTitle: 'Pasta with vegetables',
                      imageAsset: 'assets/images/Pastawithveg.jpg',
                      calories: '360 kcal - 120g',
                      protein: 10,
                      fats: 5,
                      carbs: 60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// RecipeCard Widget with MacroData
class RecipeCard extends StatelessWidget {
  final String recipeTitle;
  final String imageAsset;
  final String calories;
  final int protein;
  final int fats;
  final int carbs;

  const RecipeCard({
    required this.recipeTitle,
    required this.imageAsset,
    required this.calories,
    required this.protein,
    required this.fats,
    required this.carbs,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50, // Adjust this to control the container's width
                    height: 300,

                    child: const RotatedBox(
                      quarterTurns: -1,
                      child: Align(
                        alignment: Alignment
                            .bottomLeft, // Center the text inside the container
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0), // Adjust spacing if needed
                          child: Text(
                            'Today recipe',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .black, // Adjust text color for better contrast
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      children: [
                        // Recipe title and image
                        Text(
                          recipeTitle,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(imageAsset),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          calories,
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        // Macro bars with values
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            MacroIndicator(
                              label: 'Protein',
                              value: protein,
                              color: Colors.green,
                            ),
                            MacroIndicator(
                              label: 'Fats',
                              value: fats,
                              color: Colors.red,
                            ),
                            MacroIndicator(
                              label: 'Carbs',
                              value: carbs,
                              color: Colors.yellow,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// MacroIndicator Widget with percentage
class MacroIndicator extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const MacroIndicator(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$value g',
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 5,
          height: 20,
          decoration: BoxDecoration(
            color: color.withOpacity(0.7),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
