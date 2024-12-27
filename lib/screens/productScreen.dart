import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'Protéine Whey',
      'price': '100 DT',
      'image':
          'https://pharma-shop.tn/16471-large_default/impact-proteine-isolate-whey-.webp'
    },
    {
      'name': 'BCAA',
      'price': '50 DT',
      'image':
          'https://pharma-shop.tn/16476-large_default/impact-performance-bcaa.jpg'
    },
    {
      'name': 'Créatine',
      'price': '80 DT',
      'image':
          'https://nutribeast.tn/1369-home_default/micronised-creatine-powder-optimum-nutrition-317g.jpg'
    },
  ];

  List<Map<String, dynamic>> _filteredProducts = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredProducts = _products;
  }

  void _filterProducts(String query) {
    setState(() {
      _filteredProducts = _products
          .where((product) =>
              product['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _saveProductToDatabase(Map<String, dynamic> product) async {
    final DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref('nihel/produitAchter/${product['name']}');

    await databaseRef.set({
      'name': product['name'],
      'price': product['price'],
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produits Disponibles'),
        backgroundColor: Colors.teal,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterProducts,
              decoration: InputDecoration(
                hintText: 'Rechercher un produit...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _filteredProducts.length,
        itemBuilder: (context, index) {
          final product = _filteredProducts[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4,
            child: ListTile(
              leading: Image.network(
                product['image'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                product['name'],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Prix : ${product['price']}',
                style: const TextStyle(color: Colors.teal),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () async {
                  await _saveProductToDatabase(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product['name']} acheté avec succès !'),
                    ),
                  );
                },
                child: const Text('Acheter'),
              ),
            ),
          );
        },
      ),
    );
  }
}
