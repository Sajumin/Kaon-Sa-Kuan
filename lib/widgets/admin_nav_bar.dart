import 'package:flutter/material.dart';

const Color _tangerine = Color(0xFFF47B42);
const Color _activeIcon = Color(0xFFFFF5F0);  
const Color _inactiveIcon = Color(0xFFF9C06A); 

class AdminNavItem {
  final IconData icon;
  final String label;
  const AdminNavItem({required this.icon, required this.label});
}

const List<AdminNavItem> _navItems = [
  AdminNavItem(icon: Icons.home_rounded,          label: 'home'),
  AdminNavItem(icon: Icons.receipt_long_rounded,  label: 'pending restos'),
  AdminNavItem(icon: Icons.add_box_rounded,       label: 'add new'),
  AdminNavItem(icon: Icons.grid_view_rounded,     label: 'view reports'),
];

class AdminNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AdminNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: _tangerine,
        boxShadow: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 10,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 64,
          child: Row(
            children: List.generate(_navItems.length, (index) {
              final item      = _navItems[index];
              final isActive  = index == currentIndex;
              final iconColor = isActive ? _activeIcon : _inactiveIcon;

              return Expanded(
                child: GestureDetector(
                  onTap: () => onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 150),
                    opacity: isActive ? 1.0 : 0.75,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedScale(
                          scale: isActive ? 1.15 : 1.0,
                          duration: const Duration(milliseconds: 150),
                          child: Icon(
                            item.icon,
                            color: iconColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 11,
                            color: iconColor,
                            fontWeight: isActive
                                ? FontWeight.w700
                                : FontWeight.w400,
                            letterSpacing: 0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}