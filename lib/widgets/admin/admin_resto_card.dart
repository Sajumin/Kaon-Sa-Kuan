import 'package:flutter/material.dart';
import 'admin_app_colors.dart';
import 'admin_icon_chip.dart';

/// Unified restaurant card used on both the homepage list and the
/// pending-submissions list.
///
/// Pass [onApprove] and [onDisapprove] only for pending cards — they render
/// the approve/disapprove buttons in the footer when provided.
/// Pass [onDelete] for the homepage card — it renders the delete icon chip.
class AdminRestoCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onDisapprove;
  final VoidCallback? onApprove;

  const AdminRestoCard({
    super.key,
    required this.data,
    required this.onTap,
    this.onEdit,
    this.onDelete,
    this.onDisapprove,
    this.onApprove,
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
          border: Border.all(color: kGoldenBorder, width: 1.5),
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
                      AdminIconChip(
                          icon: Icons.edit_outlined, onTap: onEdit),
                      if (onDelete != null) ...[
                        const SizedBox(width: 5),
                        AdminIconChip(
                            icon: Icons.delete_outline, onTap: onDelete),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            Container(height: 1.5, color: kGoldenBorder),
            Container(
              decoration: const BoxDecoration(
                color: kCardBg,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined,
                          size: 15, color: kWarmTangerine),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          data['location'],
                          style: const TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 18,
                            color: kWarmTangerine,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.receipt_outlined,
                          size: 15, color: kWarmTangerine),
                      const SizedBox(width: 3),
                      Flexible(
                        child: Text(
                          priceRange,
                          style: const TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 16,
                            color: kWarmTangerine,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  // Approve + Disapprove buttons — only for pending cards
                  if (onApprove != null || onDisapprove != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        if (onDisapprove != null)
                          Expanded(
                            child: _DisapproveButton(onTap: onDisapprove!),
                          ),
                        if (onApprove != null && onDisapprove != null)
                          const SizedBox(width: 8),
                        if (onApprove != null)
                          Expanded(
                            child: _ApproveButton(onTap: onApprove!),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
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
          color: kApproveGreenBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kApproveGreen, width: 1.5),
        ),
        child: const Center(
          child: Text(
            'approve',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 14,
              color: kApproveGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _DisapproveButton extends StatelessWidget {
  final VoidCallback onTap;
  const _DisapproveButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: kDeletePinkBg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kDeletePink, width: 1.5),
        ),
        child: const Center(
          child: Text(
            'disapprove',
            style: TextStyle(
              fontFamily: 'Afacad',
              fontSize: 14,
              color: kDeletePink,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}