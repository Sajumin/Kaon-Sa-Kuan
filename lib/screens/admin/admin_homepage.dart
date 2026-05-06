import 'package:flutter/material.dart';

class AdminHomepage extends StatelessWidget {
  const AdminHomepage({super.key});

  static const Color warmTangerine = Color(0xFFF47B42);

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Good day, Admin Kuan.',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'What would you like to do?',
                    style: TextStyle(
                      fontFamily: 'Afacad',
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.88),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // Search Bar Section
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
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
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    style: const TextStyle(fontFamily: 'Afacad', fontSize: 15, color: Color(0xFF5A3E2B)),
                    decoration: InputDecoration(
                      hintText: 'search for restaurant...',
                      hintStyle: TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 15,
                        color: const Color(0xFF5A3E2B).withOpacity(0.45),
                      ),
                      prefixIcon: const Icon(Icons.search, color: warmTangerine, size: 22),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.tune_rounded, color: warmTangerine, size: 28),
            ],
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