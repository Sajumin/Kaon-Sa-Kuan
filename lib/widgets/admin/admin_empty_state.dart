import 'package:flutter/material.dart';
import 'admin_app_colors.dart';

/// Generic empty-state placeholder used across admin list screens.
///
/// ```dart
/// AdminEmptyState(
///   icon: Icons.storefront_outlined,
///   message: 'No restaurants yet.',
/// )
/// ```
class AdminEmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const AdminEmptyState({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 72,
            color: kWarmTangerine.withOpacity(0.25),
          ),
          const SizedBox(height: 16),
          Text(
            message,
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