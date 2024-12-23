import 'package:flutter/material.dart';
import 'package:coachiny/models/cart_item.dart';
import 'package:coachiny/models/ingredient.dart';

class Panier extends StatefulWidget {
  final List<CartItem> cartItems;

  Panier({Key? key, required this.cartItems}) : super(key: key);

  @override
  _PanierState createState() => _PanierState();
}

class _PanierState extends State<Panier> {
  late List<CartItem> cartItems;

  @override
  void initState() {
    super.initState();
    cartItems = widget.cartItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF8FD),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Revenir à l'écran précédent
          },
        ),
        title: const Text(
          "Panier",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          const Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/Pastawithveg.jpg'), // Image de profil
              radius: 20,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
                    child: Text(
                      "Votre panier est vide.",
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return _buildCartItem(cartItems[index]);
                    },
                  ),
          ),
          _buildTotalSummary(),
        ],
      ),
    );
  }

  // Widget pour chaque élément du panier
  Widget _buildCartItem(CartItem item) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Vous pouvez réactiver la gestion des quantités si nécessaire
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove, size: 16),
                      onPressed: () {
                        setState(() {
                          if (item.quantity > 1) {
                            item.quantity -= 1;
                          }
                        });
                      },
                    ),
                    Text(
                      item.quantity.toString(),
                      style: const TextStyle(
                          fontSize: 14.0, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, size: 16),
                      onPressed: () {
                        setState(() {
                          item.quantity += 1;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            */
            const SizedBox(height: 8.0),
            // Liste des ingrédients avec détails
            const Text(
              "Ingrédients :",
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: item.ingredients.map((ingredient) {
                double totalCalories = ingredient.calories * item.quantity;
                double totalPrice = ingredient.price * item.quantity;
                double totalWeight = ingredient.weight * item.quantity;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(
                    children: [
                      // Nom de l'ingrédient
                      Expanded(
                        child: Text(
                          ingredient.name,
                          style: const TextStyle(
                            fontSize: 12.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      // Détails de l'ingrédient
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Prix: ${ingredient.price.toStringAsFixed(2)} TND",
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Quantité: ${totalWeight.toStringAsFixed(0)}g",
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Calories: ${totalCalories.toStringAsFixed(0)} kcal",
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "Total: ${totalCalories.toStringAsFixed(0)} kcal, ${totalPrice.toStringAsFixed(2)} TND",
                            style: const TextStyle(
                              fontSize: 12.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  // Widget pour la section récapitulative des totaux
  Widget _buildTotalSummary() {
    double totalFoodCost = cartItems.fold(0.0, (sum, item) {
      // Calculer le total pour chaque élément du panier
      double itemTotal = item.ingredients.fold(0.0, (itemSum, ingredient) {
        return itemSum + (ingredient.price * item.quantity);
      });
      return sum + itemTotal;
    });

    double deliveryCharge = 2.50; // Frais de livraison fixés à 2.50 TND
    double grandTotal = totalFoodCost + deliveryCharge;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSummaryRow(
              "Total des Aliments", "${totalFoodCost.toStringAsFixed(2)} TND"),
          _buildSummaryRow(
              "Frais de Livraison", "${deliveryCharge.toStringAsFixed(2)} TND"),
          const Divider(thickness: 1.0, color: Colors.grey),
          _buildSummaryRow(
            "Total Général",
            "${grandTotal.toStringAsFixed(2)} TND",
            isBold: true,
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () {
              // Ajoutez votre logique de paiement ici
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal, // Couleur du bouton
              padding:
                  const EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text(
              "Payer",
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Widget pour chaque ligne de récapitulatif
  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
