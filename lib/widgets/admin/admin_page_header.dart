import 'package:flutter/material.dart';
import 'admin_app_colors.dart';

/// Orange SafeArea header used by Pending Restos, View Reports, etc.
///
/// Usage (with count badge):
/// ```dart
/// AdminPageHeader(
///   title: 'Community Reports',
///   subtitle: 'Here are the reports made by the Kuaners.',
///   badgeLabel: '3 reports',
/// )
/// ```
///
/// Usage (with trailing widget, e.g. logout button):
/// ```dart
/// AdminPageHeader(
///   title: 'Good day, Admin Kuan.',
///   subtitle: 'What would you like to do?',
///   trailing: IconButton(...),
/// )
/// ```
class AdminPageHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  /// Optional pre-built badge label string (e.g. "3 reports").
  /// Rendered as a dark pill on the right side.
  final String? badgeLabel;

  /// Fully custom trailing widget — overrides [badgeLabel] when provided.
  final Widget? trailing;

  const AdminPageHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.badgeLabel,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    Widget? trailingWidget = trailing;

    if (trailingWidget == null && badgeLabel != null) {
      trailingWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          badgeLabel!,
          style: const TextStyle(
            fontFamily: 'Afacad',
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      color: kWarmTangerine,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontFamily: 'Afacad',
                        fontSize: 22,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                  ],
                ),
              ),
              if (trailingWidget != null) trailingWidget,
            ],
          ),
        ),
      ),
    );
  }
}