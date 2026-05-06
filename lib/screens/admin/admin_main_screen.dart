import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/widgets/admin_nav_bar.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_homepage.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_pending_restos.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_view_reports.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_add_new.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const AdminHomepage(),
    const AdminPendingRestos(),
    const SizedBox.shrink(), // Index 2 placeholder for "Add New"
    const AdminViewReports(),
  ];

  void _onNavTap(int index) {
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AddNewResto()),
      );
    } else {
      setState(() => _currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: AdminNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}