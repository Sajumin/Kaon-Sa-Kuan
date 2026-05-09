import 'package:flutter/material.dart';

class AdminViewReports extends StatelessWidget {
  const AdminViewReports({super.key});

  static const Color warmTangerine = Color(0xFFF47B42);

  // Hardcoded reports
  static const List<String> _reports = [
    "Pwede po pa-remove ng Scarlet's? Matagal na po kasi sila close tapos sinuggest po siya ng app samin. Thank you po!",
    "Pa-update po ng price ng Red Table! 100 lang dala kong pera tapos nag 110 na pala yung special nila.",
    "Pa-update po ng closing time ng CLS. Pumunta po ko dun 8 pm pero sarado na pala sila 7 pa lang : (",
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
                          fontSize: 14,
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
                    child: Text(
                      '${_reports.length} ${_reports.length == 1 ? 'report' : 'reports'}',
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
        _reports.isEmpty
            ? const Expanded(child: _EmptyState())
            : Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _reports.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _ReportCard(message: _reports[index]),
                ),
              ),
      ],
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String message;
  const _ReportCard({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF9C06A), width: 1.5),
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontFamily: 'Afacad',
          fontSize: 18,
          color: Colors.black87,
          height: 1.5,
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
          Icon(Icons.receipt_long_outlined,
              size: 72,
              color: const Color(0xFFF47B42).withOpacity(0.25)),
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