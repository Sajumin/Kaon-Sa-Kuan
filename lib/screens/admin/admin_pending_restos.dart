import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_resto_details.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_edit_resto.dart';

class AdminPendingRestos extends StatelessWidget {
  const AdminPendingRestos({super.key});

  static const Color warmTangerine = Color(0xFFF47B42);

  static const List<Map<String, dynamic>> _pendingRestos = [
    {
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
          "Affordable silog and karinderya meals for students and locals.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                        'Restaurants Submitted',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Restaurants submitted by the Kuaners.',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${_pendingRestos.length} ${_pendingRestos.length == 1 ? 'resto' : 'restos'}',
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        _pendingRestos.isEmpty
            ? const Expanded(child: _EmptyState())
            : Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _pendingRestos.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) => _PendingRestoCard(
                    data: _pendingRestos[index],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            AdminRestoDetails(resto: _pendingRestos[index]),
                      ),
                    ),
                    onApprove: () => _showApproveModal(
                        context, _pendingRestos[index]['name']),
                    onEdit: () => showEditRestoModal(
                      context,
                      data: _pendingRestos[index],
                      onSave: (updated) {
                        // TODO: persist updated data
                      },
                    ),
                    onDelete: () =>
                        _showDeleteModal(context, _pendingRestos[index]['name']),
                  ),
                ),
              ),
      ],
    );
  }

  void _showApproveModal(BuildContext context, String restoName) {
    showDialog(
      context: context,
      builder: (_) => _ConfirmModal(
        icon: Icons.check_circle_outline_rounded,
        iconColor: const Color(0xFF4CAF50),
        iconBgColor: const Color(0xFFE8F5E9),
        title: 'Approve Restaurant?',
        message:
            'You\'re about to add "$restoName" to the official restaurant list. Make sure all the details look good before approving.',
        confirmLabel: 'Yes, approve it!',
        confirmColor: const Color(0xFF4CAF50),
        confirmBgColor: const Color(0xFFE8F5E9),
        onConfirm: () {
          Navigator.pop(context);
          // TODO: handle approve logic
        },
      ),
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
            '"$restoName" will be permanently removed from the submissions. This can\'t be undone.',
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

class _PendingRestoCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final VoidCallback onApprove;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _PendingRestoCard({
    required this.data,
    required this.onTap,
    required this.onApprove,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final String priceRange =
        'Php ${data['averageCostMin']} – Php ${data['averageCostMax']}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFF9C06A), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            Container(height: 1.5, color: const Color(0xFFF9C06A)),
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
                  const SizedBox(height: 12),
                  _ApproveButton(onTap: onApprove),
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
          border: Border.all(color: const Color(0xFFF9C06A), width: 1),
        ),
        child: Icon(icon, size: 24, color: Colors.black87),
      ),
    );
  }
}

class _ApproveButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ApproveButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFE8F5E9),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
        ),
        child: const Center(
          child: Text(
            'approve',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 14,
              color: Color(0xFF4CAF50),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.storefront_outlined,
              size: 72, color: const Color(0xFFF47B42).withOpacity(0.25)),
          const SizedBox(height: 16),
          Text(
            'No restaurants yet.',
            style: TextStyle(
              fontFamily: 'AdlamDisplay',
              fontSize: 16,
              color: const Color(0xFF5A3E2B).withOpacity(0.45),
            ),
          ),
        ],
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