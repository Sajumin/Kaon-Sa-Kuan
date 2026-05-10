import 'package:flutter/material.dart';
import 'admin_app_colors.dart';

/// Expandable checkbox tag grid shared by AddNewResto and the edit sheet.
///
/// Manages its own expand/collapse state. Calls [onChanged] whenever the
/// selection set changes so the parent can react.
///
/// ```dart
/// AdminTagSelector(
///   selectedTags: _selectedTags,
///   onChanged: (updated) => setState(() => _selectedTags = updated),
/// )
/// ```
class AdminTagSelector extends StatefulWidget {
  final Set<String> selectedTags;
  final ValueChanged<Set<String>> onChanged;

  static const List<String> defaultTagList = [
    'Breakfast', 'Streetfood', 'Coffee',  'Lunch',    'Drinks',  'Pastry',
    'Dinner',    'Sushi',      'Pasta',   'Merienda', 'Noodles', 'Pizza',
    'Chicken',   'BBQ / Grill','Veggies', 'Pork',     'Samgyup', 'Fish',
    'Silog',     'Soup',       'Seafood',
  ];

  const AdminTagSelector({
    super.key,
    required this.selectedTags,
    required this.onChanged,
  });

  @override
  State<AdminTagSelector> createState() => _AdminTagSelectorState();
}

class _AdminTagSelectorState extends State<AdminTagSelector> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle header
        GestureDetector(
          onTap: () => setState(() => _expanded = !_expanded),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: kWarmTangerine),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      'Tags',
                      style: TextStyle(
                        fontFamily: 'Afacad',
                        color: kWarmTangerine,
                        fontSize: 16,
                      ),
                    ),
                    if (widget.selectedTags.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: kWarmTangerine.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${widget.selectedTags.length} selected',
                          style: const TextStyle(
                            fontFamily: 'Afacad',
                            color: kWarmTangerine,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                Icon(
                  _expanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),

        // Checkbox grid
        if (_expanded)
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Wrap(
              spacing: 8,
              runSpacing: 0,
              children: AdminTagSelector.defaultTagList.map((tag) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: widget.selectedTags.contains(tag),
                        activeColor: kWarmTangerine,
                        onChanged: (val) {
                          final updated = Set<String>.from(widget.selectedTags);
                          val! ? updated.add(tag) : updated.remove(tag);
                          widget.onChanged(updated);
                        },
                      ),
                      Expanded(
                        child: Text(
                          tag,
                          style: const TextStyle(
                              fontFamily: 'Afacad', fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}