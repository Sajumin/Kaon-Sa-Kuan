import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:kaon_sa_kuan/screens/admin/admin_resto_details.dart';
import 'package:kaon_sa_kuan/screens/auth/landing.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_edit_resto.dart';
import 'package:kaon_sa_kuan/backend/services/auth_service.dart';
import 'package:kaon_sa_kuan/backend/services/restaurant_service.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_app_colors.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_confirm_modal.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_resto_card.dart';

class AdminHomepage extends StatelessWidget {
  AdminHomepage({super.key});

  final RestaurantService _restaurantService = RestaurantService();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── HEADER ─────────────────────────────
        Container(
          width: double.infinity,
          color: kWarmTangerine,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // FIXED: removed double const
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good day, Admin Kuan.',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'What would you like to do?',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      await AuthService().signOut();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LandingPage(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── SEARCH ─────────────────────────────
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'search for restaurant...',
              prefixIcon: const Icon(
                Icons.search,
                color: kWarmTangerine,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // ── RESTAURANT LIST ─────────────────────
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: _restaurantService.getRestaurantsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              final docs = snapshot.data?.docs ?? [];

              if (docs.isEmpty) {
                return const Center(
                  child: Text('No restaurants found'),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final doc = docs[index];
                  final data = doc.data() as Map<String, dynamic>;
                  final id = doc.id;

                  return AdminRestoCard(
                    data: data,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AdminRestoDetails(
                            resto: data,
                          ),
                        ),
                      );
                    },
                    onEdit: () {
                      showEditRestoModal(
                        context,
                        data: data,
                        onSave: (updated) async {
                          await _restaurantService.updateRestaurant(
                            id,
                            updated,
                          );
                        },
                      );
                    },
                    onDelete: () {
                      _showDeleteModal(
                        context,
                        id,
                        data['name'] ?? '',
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  // ───────────────── DELETE ─────────────────
  void _showDeleteModal(
    BuildContext context,
    String id,
    String name,
  ) {
    showDialog(
      context: context,
      builder: (_) => AdminConfirmModal(
        icon: Icons.delete_outline_rounded,
        iconColor: Colors.red,
        iconBgColor: Colors.red.shade50,
        title: 'Delete Restaurant?',
        message: '"$name" will be permanently deleted.',
        confirmLabel: 'Delete',
        confirmColor: Colors.red,
        confirmBgColor: Colors.red.shade50,
        onConfirm: () async {
          await _restaurantService.deleteRestaurant(id);

          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
