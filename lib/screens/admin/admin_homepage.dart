import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_resto_details.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_edit_resto.dart';
import 'package:kaon_sa_kuan/backend/services/auth_service.dart';
import 'package:kaon_sa_kuan/screens/auth/landing.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  static const Color warmTangerine = Color(0xFFF47B42);

  // Hardcoded Restaurant Data
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
    "description":
        "Affordable silog and karinderya meals for students and locals."
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          color: warmTangerine,
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
                    icon:
                        const Icon(Icons.logout_rounded, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Search Bar
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
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: const Offset(0, 2)),
                    ],
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: 'search for restaurant...',
                      prefixIcon: Icon(Icons.search, color: warmTangerine),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.tune_rounded, color: warmTangerine, size: 28),
            ],
          ),
        ),

        // Restaurant List
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              _RestoCard(
                data: susansResto,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminRestoDetails(resto: susansResto),
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
      builder: (_) => _ConfirmModal(
        icon: Icons.delete_outline_rounded,
        iconColor: const Color(0xFFE91E63),
        iconBgColor: const Color(0xFFFCE4EC),
        title: 'Remove This Resto?',
        message:
            '"$restoName" will be permanently removed from the list. This can\'t be undone.',
        confirmLabel: 'Yes, delete it.',
        confirmColor: const Color(0xFFE91E63),
        confirmBgColor: const Color(0xFFFCE4EC),
        onConfirm: () {
          Navigator.pop(context);
          // TODO: handle delete logic
        },
      ),
    );
  }
}

class _RestoCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const _RestoCard({
    required this.data,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final String priceRange =
        'Php ${data['averageCostMin']} – Php ${data['averageCostMax']}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFFF9C06A),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Area
            Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(18)),
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    color: Colors.white,
                    child: Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 52,
                        color: Colors.black.withOpacity(0.15),
                      ),
                    ),
                  ),
                ),
                // Edit & Delete buttons
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: [
                      _IconChip(icon: Icons.edit_outlined, onTap: onEdit),
                      const SizedBox(width: 5),
                      _IconChip(icon: Icons.delete_outline, onTap: onDelete),
                    ],
                  ),
                ),
              ],
            ),

            Container(
              height: 1.5,
              color: const Color(0xFFF9C06A),
            ),

            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFF5F0),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(18)),
              ),
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'],
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 15, color: Color(0xFFF47B42)),
                      const SizedBox(width: 3),
                      Text(
                        data['location'],
                        style: const TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 20,
                          color: Color(0xFFF47B42),
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.receipt_outlined,
                          size: 15, color: Color(0xFFF47B42)),
                      const SizedBox(width: 3),
                      Text(
                        priceRange,
                        style: const TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 20,
                          color: Color(0xFFF47B42),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconChip extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconChip({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.90),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFF9C06A),
            width: 1,
          ),
        ),
        child: Icon(icon, size: 24, color: Colors.black87),
      ),
    );
  }
}

// ─── Shared Confirmation Modal ───────────────────────────────────────────────

class _ConfirmModal extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String message;
  final String confirmLabel;
  final Color confirmColor;
  final Color confirmBgColor;
  final VoidCallback onConfirm;

  const _ConfirmModal({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.confirmColor,
    required this.confirmBgColor,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon badge
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
                border:
                    Border.all(color: iconColor.withOpacity(0.3), width: 2),
              ),
              child: Icon(icon, color: iconColor, size: 32),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Afacad',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),

            // Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Afacad',
                fontSize: 15,
                color: Colors.black.withOpacity(0.5),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                // Cancel
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: Colors.black.withOpacity(0.1), width: 1.5),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                // Confirm
                Expanded(
                  child: GestureDetector(
                    onTap: onConfirm,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: confirmBgColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: confirmColor, width: 1.5),
                      ),
                      child: Center(
                        child: Text(
                          confirmLabel,
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: confirmColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}