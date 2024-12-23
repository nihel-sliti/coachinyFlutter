import 'package:flutter/material.dart';
import 'package:coachiny/models/meal.dart';
import 'package:coachiny/screens/Recipedetailscreen.dart';
import 'package:coachiny/services/recipe_service.dart';

class RecipesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.restaurant_menu, size: 28), // Icône de menu
            SizedBox(width: 8),
            Text("Recettes"),
          ],
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: loadRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("Erreur de chargement",
                  style: TextStyle(color: Colors.red)),
            );
          }

          final recipes = snapshot.data ?? [];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: recipes.length,
              itemBuilder: (context, index) {
                final meal = recipes[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Icon(Icons.fastfood, size: 40, color: Colors.teal),
                    title: Text(
                      meal['Nom_de_la_Recette'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Calories: ${meal['Calories']} kcal"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Recipedetailscreen(
                                meal: Meal.fromJson(meal));
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
