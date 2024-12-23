// lib/models/offer.dart
class Offer {
  final String title;
  final List<String> features;
  final String price;
  final String duration; // Par exemple : "Période : 1 Mois"

  Offer({
    required this.title,
    required this.features,
    required this.price,
    required this.duration,
  });
}
