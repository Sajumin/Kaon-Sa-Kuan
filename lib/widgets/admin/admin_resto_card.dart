import 'package:flutter/material.dart';
import 'admin_app_colors.dart';
import 'admin_icon_chip.dart';

class AdminRestoCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onApprove;

  const AdminRestoCard({
    super.key,
    required this.data,
    required this.onTap,
    this.onEdit,
    this.onDelete,
    this.onApprove,
  });

  @override
  Widget build(BuildContext context) {
    final String priceRange = data['priceRange'] ?? 'N/A';

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
            // ── IMAGE ─────────────────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 160,
                    child: (data['imageUrl'] != null &&
                            data['imageUrl'].toString().isNotEmpty)
                        ? Image.network(
                            data['imageUrl'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _placeholder();
                            },
                          )
                        : _placeholder(),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Row(
                    children: [
                      AdminIconChip(
                        icon: Icons.edit_outlined,
                        onTap: onEdit,
                      ),
                      const SizedBox(width: 5),
                      AdminIconChip(
                        icon: Icons.delete_outline,
                        onTap: onDelete,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Container(height: 1.5, color: kGoldenBorder),

            // ── FOOTER ─────────────────────────────
            Container(
              decoration: const BoxDecoration(
                color: kCardBg,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(18),
                ),
              ),
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['name'] ?? '',
                    style: const TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 15,
                        color: kWarmTangerine,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        data['location'] ?? '',
                        style: const TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 18,
                          color: kWarmTangerine,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.receipt_outlined,
                        size: 15,
                        color: kWarmTangerine,
                      ),
                      const SizedBox(width: 3),
                      Text(
                        priceRange,
                        style: const TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 18,
                          color: kWarmTangerine,
                        ),
                      ),
                    ],
                  ),
                  if (onApprove != null) ...[
                    const SizedBox(height: 12),
                    _ApproveButton(onTap: onApprove!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Icon(
          Icons.image_outlined,
          size: 52,
          color: Colors.black.withOpacity(0.15),
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
              color: kApproveGreen,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
