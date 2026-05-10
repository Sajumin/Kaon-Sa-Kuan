import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_app_colors.dart';

class AdminRestoDetails extends StatelessWidget {
  final Map<String, dynamic> resto;

  const AdminRestoDetails({super.key, required this.resto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Orange header with back button
          Container(
            width: double.infinity,
            color: kWarmTangerine,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 20, 16),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white),
                    ),
                    Text(
                      resto['name'],
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── IMAGE SECTION ─────────────────────
          if (resto['imageUrl'] != null &&
              resto['imageUrl'].toString().isNotEmpty)
            Image.network(
              resto['imageUrl'],
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 220,
                  width: double.infinity,
                  color: Colors.grey.shade200,
                  child: const Icon(
                    Icons.broken_image_outlined,
                    size: 60,
                  ),
                );
              },
            )
          else
            Container(
              height: 220,
              width: double.infinity,
              color: Colors.grey.shade200,
              child: const Icon(
                Icons.image_outlined,
                size: 60,
              ),
            ),

          // Content
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _infoTile(
                  "Category",
                  resto['foodCategory'] ?? '',
                ),
                _infoTile(
                  "Food Types",
                  (resto['foodType'] as List?)?.join(", ") ?? '',
                ),
                _infoTile(
                  "Price Range",
                  "₱${resto['averageCostMin']} - ₱${resto['averageCostMax']}",
                ),
                _infoTile(
                  "Budget Tags",
                  (resto['budgetTags'] as List?)?.join(", ") ?? '',
                ),
                _infoTile(
                  "Location",
                  resto['location'] ?? '',
                ),
                _infoTile(
                  "Hours",
                  "${resto['openTime']} - ${resto['closeTime']}",
                ),
                _infoTile(
                  "Meals",
                  (resto['mealTags'] as List?)?.join(", ") ?? '',
                ),
                _infoTile(
                  "Description",
                  resto['description'] ?? '',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: kWarmTangerine,
              fontFamily: 'Afacad',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 16, fontFamily: 'Afacad'),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
