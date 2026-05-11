import 'package:firebase_auth/firebase_auth.dart';
import '../models/restaurant_model.dart';
import '../services/restaurant_service.dart';

class RestaurantController {
  final RestaurantService _restaurantService = RestaurantService();

  Future<void> addRestaurant({
    required String name,
    required String description,
    required String location,
    required String priceRange,
    required String openingHours,
    required String facebookPage,
    required List<String> tags,
    required String imageUrl,
  }) async {
    // Basic validation
    if (name.trim().isEmpty) {
      throw Exception("Restaurant name is required");
    }

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception("You must be logged in to add a restaurant.");
    }

    final restaurant = RestaurantModel(
      id: '',
      name: name,
      description: description,
      location: location,
      priceRange: priceRange,
      openingHours: openingHours,
      facebookPage: facebookPage,
      imageUrl: imageUrl,
      tags: tags,
      approvedBy: FirebaseAuth.instance.currentUser!.uid,
      status: 'approved',
      createdByAdmin: true,
    );

    await _restaurantService.addRestaurant(restaurant);
  }
}
