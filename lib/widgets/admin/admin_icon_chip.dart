import 'package:flutter/material.dart';
import 'admin_app_colors.dart';

/// Small icon button chip used on restaurant cards (edit, delete, etc.).
class AdminIconChip extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const AdminIconChip({super.key, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.90),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kGoldenBorder, width: 1),
        ),
        child: Icon(icon, size: 24, color: Colors.black87),
      ),
    );
  }
}