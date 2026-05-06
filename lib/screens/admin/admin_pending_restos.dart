import 'package:flutter/material.dart';

class AdminPendingRestos extends StatelessWidget {
  const AdminPendingRestos({super.key});

  static const Color warmTangerine = Color(0xFFF47B42);

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
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: Text(
                  'Restaurants Submitted',
                  style: TextStyle(
                    fontFamily: 'Afacad',
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ),
        const Expanded(child: _EmptyState()),
      ],
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
          Icon(Icons.storefront_outlined, size: 72, color: const Color(0xFFF47B42).withOpacity(0.25)),
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