import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/restaurant_model.dart';

class RestaurantService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRestaurant(RestaurantModel restaurant) async {
    await _firestore.collection('restaurants').add({
      ...restaurant.toMap(),
      'createdAt': Timestamp.now(),
    });
  }

  Stream<List<RestaurantModel>> getRestaurants() {
    return _firestore.collection('restaurants').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return RestaurantModel.fromMap(
            doc.id,
            doc.data(),
          );
        }).toList();
      },
    );
  }

  Future<void> deleteRestaurant(String id) async {
    await _firestore.collection('restaurants').doc(id).delete();
  }

  Future<void> updateRestaurant(
    String id,
    Map<String, dynamic> data,
  ) async {
    await _firestore.collection('restaurants').doc(id).update(data);
  }
}
