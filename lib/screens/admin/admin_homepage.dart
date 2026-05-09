import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_resto_details.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_edit_resto.dart';
import 'package:kaon_sa_kuan/backend/services/auth_service.dart';
import 'package:kaon_sa_kuan/screens/auth/landing.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_app_colors.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_confirm_modal.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_resto_card.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  // Hardcoded restaurant data
  final Map<String, dynamic> susansResto = const {
    "name": "Susan's",
    "foodCategory": "Full Meal",
    "foodType": ["Karinderya", "Silog"],
    "averageCostMin": 35,
    "averageCostMax": 150,
    "budgetTags": ["Budget Meal", "Affordable"],
    "location": "Hollywood St.",
    "openTime": "06:00",
    "closeTime": "20:00",
    "mealTags": ["Breakfast", "Lunch", "Dinner"],
    "description": "Affordable silog and karinderya meals for students and locals.",
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── Header ────────────────────────────────────────────────────────
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
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
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () async {
                      await AuthService().signOut();
                      if (context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LandingPage()),
                          (route) => false,
                        );
                      }
                    },
                    icon: const Icon(Icons.logout_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),

        // ── Search Bar ────────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 2)),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'search for restaurant...',
                      prefixIcon:
                          Icon(Icons.search, color: kWarmTangerine),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.tune_rounded,
                  color: kWarmTangerine, size: 28),
            ],
          ),
        ),

        // ── Restaurant List ───────────────────────────────────────────────
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              AdminRestoCard(
                data: susansResto,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        AdminRestoDetails(resto: susansResto),
                  ),
                ),
                onEdit: () => showEditRestoModal(
                  context,
                  data: susansResto,
                  onSave: (updated) {
                    // TODO: persist updated data
                  },
                ),
                onDelete: () =>
                    _showDeleteModal(context, susansResto['name']),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDeleteModal(BuildContext context, String restoName) {
    showDialog(
      context: context,
      builder: (_) => AdminConfirmModal(
        icon: Icons.delete_outline_rounded,
        iconColor: kDeletePink,
        iconBgColor: kDeletePinkBg,
        title: 'Remove This Resto?',
        message:
            '"$restoName" will be permanently removed from the list. This can\'t be undone.',
        confirmLabel: 'Yes, delete it.',
        confirmColor: kDeletePink,
        confirmBgColor: kDeletePinkBg,
        onConfirm: () {
          Navigator.pop(context);
          // TODO: handle delete logic
        },
      ),
    );
  }
}