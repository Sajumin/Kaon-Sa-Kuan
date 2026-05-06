import 'package:flutter/material.dart';

class AdminViewReports extends StatelessWidget {
  const AdminViewReports({super.key});

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
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Community Reports',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Here are the reports made by the Kuaners.',
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '0 reports',
                      style: TextStyle(fontFamily: 'Afacad', fontSize: 12, color: Colors.white),
                    ),
                  ),
                ],
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
          Icon(Icons.receipt_long_outlined, size: 72, color: const Color(0xFFF47B42).withOpacity(0.25)),
          const SizedBox(height: 16),
          Text(
            'No reports yet.',
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