import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_resto_details.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_edit_resto.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_app_colors.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_confirm_modal.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_empty_state.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_page_header.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_resto_card.dart';

class AdminPendingRestos extends StatelessWidget {
  const AdminPendingRestos({super.key});

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
    {
      "name": "Campus Bites",
      "foodCategory": "Quick Meals",
      "foodType": ["Burgers", "Silog"],
      "averageCostMin": 45,
      "averageCostMax": 160,
      "budgetTags": ["Budget Meal", "Student Favorite"],
      "location": "CUB",
      "openTime": "09:00",
      "closeTime": "21:00",
      "mealTags": ["Lunch", "Dinner"],
      "description":
          "Affordable burgers, rice meals, and snacks for students.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final count = _pendingRestos.length;

    return Column(
      children: [
        AdminPageHeader(
          title: 'Restaurants Submitted',
          subtitle: 'Restaurants submitted by the Kuaners.',
          badgeLabel: '$count ${count == 1 ? 'resto' : 'restos'}',
        ),
        _pendingRestos.isEmpty
            ? const Expanded(
                child: AdminEmptyState(
                  icon: Icons.storefront_outlined,
                  message: 'No restaurants yet.',
                ),
              )
            : Expanded(
                child: Builder(
                  builder: (context) {
                    final width = MediaQuery.of(context).size.width;
                    final isTablet = width >= 700;

                    if (isTablet) {
                      final cardWidth = (width - 32 - 16) / 2;
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: _pendingRestos.map((resto) {
                            return SizedBox(
                              width: cardWidth,
                              child: AdminRestoCard(
                                data: resto,
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        AdminRestoDetails(resto: resto),
                                  ),
                                ),
                                onApprove: () => _showApproveModal(
                                    context, resto['name']),
                                onDisapprove: () => _showDisapproveModal(
                                    context, resto['name']),
                                onEdit: () => showEditRestoModal(
                                  context,
                                  data: resto,
                                  onSave: (updated) {
                                    // TODO: persist updated data
                                  },
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: _pendingRestos.length,
                      itemBuilder: (context, index) {
                        final resto = _pendingRestos[index];
                        return AdminRestoCard(
                          data: resto,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AdminRestoDetails(resto: resto),
                            ),
                          ),
                          onApprove: () =>
                              _showApproveModal(context, resto['name']),
                          onDisapprove: () =>
                              _showDisapproveModal(context, resto['name']),
                          onEdit: () => showEditRestoModal(
                            context,
                            data: resto,
                            onSave: (updated) {
                              // TODO: persist updated data
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
      ],
    );
  }

  void _showApproveModal(BuildContext context, String restoName) {
    showDialog(
      context: context,
      builder: (_) => AdminConfirmModal(
        icon: Icons.check_circle_outline_rounded,
        iconColor: kApproveGreen,
        iconBgColor: kApproveGreenBg,
        title: 'Approve Restaurant?',
        message:
            'You\'re about to add "$restoName" to the official restaurant list. Make sure all the details look good before approving.',
        confirmLabel: 'Yes, approve it!',
        confirmColor: kApproveGreen,
        confirmBgColor: kApproveGreenBg,
        onConfirm: () {
          Navigator.pop(context);
          // TODO: handle approve logic
        },
      ),
    );
  }

  void _showDisapproveModal(BuildContext context, String restoName) {
    showDialog(
      context: context,
      builder: (_) => AdminConfirmModal(
        icon: Icons.cancel_outlined,
        iconColor: kDeletePink,
        iconBgColor: kDeletePinkBg,
        title: 'Disapprove Restaurant?',
        message:
            '"$restoName" will be rejected and removed from submissions. This can\'t be undone.',
        confirmLabel: 'Yes, disapprove it.',
        confirmColor: kDeletePink,
        confirmBgColor: kDeletePinkBg,
        onConfirm: () {
          Navigator.pop(context);
          // TODO: handle disapprove logic
        },
      ),
    );
  }
}