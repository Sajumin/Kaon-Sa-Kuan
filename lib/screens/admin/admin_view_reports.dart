import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_app_colors.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_empty_state.dart';
import 'package:kaon_sa_kuan/widgets/admin/admin_page_header.dart';

class AdminViewReports extends StatelessWidget {
  const AdminViewReports({super.key});

  static const List<String> _reports = [
    "Pwede po pa-remove ng Scarlet's? Matagal na po kasi sila close tapos sinuggest po siya ng app samin. Thank you po!",
    "Pa-update po ng price ng Red Table! 100 lang dala kong pera tapos nag 110 na pala yung special nila.",
    "Pa-update po ng closing time ng CLS. Pumunta po ko dun 8 pm pero sarado na pala sila 7 pa lang : (",
  ];

  @override
  Widget build(BuildContext context) {
    final count = _reports.length;

    return Column(
      children: [
        AdminPageHeader(
          title: 'Community Reports',
          subtitle: 'Here are the reports made by the Kuaners.',
          badgeLabel: '$count ${count == 1 ? 'report' : 'reports'}',
        ),
        _reports.isEmpty
            ? const Expanded(
                child: AdminEmptyState(
                  icon: Icons.receipt_long_outlined,
                  message: 'No reports yet.',
                ),
              )
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
        border: Border.all(color: kGoldenBorder, width: 1.5),
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