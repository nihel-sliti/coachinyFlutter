// lib/screens/OffersScreen.dart
import 'package:flutter/material.dart';
import '../models/offer.dart';

class OffersScreen extends StatelessWidget {
  // Liste des offres disponibles
  final List<Offer> offers = [
    Offer(
      title: 'OFFRE 1',
      features: [
        'Le calculateur diététique (A jusqu\'à Z)',
        'E-BOOK PDF (50 RECETTES)',
        'Fiche de suivi poids',
        'Fiche de suivi des mensurations',
        'DES VIDÉOS EXPLICATIVES',
        'BONUS : Fiche de suivi sommeil, stress, nombre de pas journalier, etc.',
      ],
      price: '59 DT',
      duration: 'Période : 1 Mois',
    ),
    Offer(
      title: 'OFFRE 2',
      features: [
        'Le calculateur de progression en entraînement',
        'Fiche de suivi poids',
        'Fiche de suivi des mensurations',
        'Fiche de suivi sommeil, stress, etc.',
        'DES VIDÉOS EXPLICATIVES',
        'BONUS : Carnet d\'entraînement PDF',
      ],
      price: '59 DT',
      duration: 'Période : 1 Mois',
    ),
    Offer(
      title: 'OFFRE 3',
      features: [
        'Le calculateur diététique (A jusqu\'à Z)',
        'Le calculateur de progression en entraînement',
        'E-BOOK (50 RECETTES)',
        'Fiche de suivi poids',
        'Fiche de suivi des mensurations',
        'DES VIDÉOS EXPLICATIVES',
        'BONUS : Fiche de suivi sommeil, stress, nombre de pas journalier, etc.',
        'Carnet d\'entraînement PDF',
      ],
      price: '99 DT',
      duration: 'Période : 1 Mois',
    ),
    Offer(
      title: 'OFFRE PREMIUM',
      features: [
        'Le calculateur diététique (A jusqu\'à Z)',
        'Le calculateur de progression en entraînement',
        'E-BOOK (50 RECETTES)',
        'Fiche de suivi poids',
        'Fiche de suivi des mensurations',
        'DES VIDÉOS EXPLICATIVES',
        'BONUS : Fiche de suivi sommeil, stress, nombre de pas journalier, etc.',
        'Carnet d\'entraînement PDF',
        'Exemple de 2 régimes alimentaires (2000 kcal et 2500 kcal)',
        'Exemple d\'un programme d\'entraînement',
        'Vidéos explicatives des exercices',
        'Vidéo descriptive du tempo dans le programme d\'entraînement',
        'Vidéo descriptive de la respiration pendant les exercices',
      ],
      price: '169 DT',
      duration: 'Période : 1 Mois',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les Offres Disponibles'),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return OfferCard(offer: offer);
        },
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final Offer offer;

  const OfferCard({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre de l'offre
            Text(
              offer.title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 8.0),
            // Liste des fonctionnalités
            ...offer.features.map((feature) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 20,
                      ),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Text(
                          feature,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(height: 12.0),
            // Prix et durée
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prix : ${offer.price}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                Text(
                  offer.duration,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            // Bouton d'action
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Action à définir : achat, détails, etc.
                  // Par exemple, afficher un message de confirmation
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Achat de ${offer.title}'),
                      content: Text(
                          'Confirmez-vous l\'achat de cette offre pour ${offer.price} ?'),
                      actions: [
                        TextButton(
                          child: Text('Annuler'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        ElevatedButton(
                          child: Text('Confirmer'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange),
                          onPressed: () {
                            // Logique d'achat à implémenter
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Offre ${offer.title} achetée avec succès !'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text(
                  'Acheter',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
