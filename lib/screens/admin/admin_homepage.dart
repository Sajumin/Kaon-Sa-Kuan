import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/widgets/admin_nav_bar.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_add_new.dart';

class AdminHomepage extends StatefulWidget {
  const AdminHomepage({super.key});

  @override
  State<AdminHomepage> createState() => _AdminHomepageState();
}

class _AdminHomepageState extends State<AdminHomepage> {
  static const Color warmTangerine = Color(0xFFF47B42);

  int _currentIndex = 0;
  final TextEditingController _searchController = TextEditingController();

  // Placeholder: replace with actual restaurant data from Firestore
  final List<Map<String, dynamic>> _restaurants = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    if (index == _currentIndex) return;
    if (index == 2) { 
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (_) => const AddNewResto())
    );
    return; 
  }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AdminNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
      body: Column(
        children: [
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
                    Text(
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

          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              children: [
                // Search Bar
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
                      controller: _searchController,
                      style: const TextStyle(
                        fontFamily: 'Afacad', 
                        fontSize: 15,
                        color: Color(0xFF5A3E2B),
                      ),
                      decoration: InputDecoration(
                        hintText: 'search for restaurant...',
                        hintStyle: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 15,
                          color: const Color(0xFF5A3E2B).withOpacity(0.45),
                        ),
                        prefixIcon: const Icon(
                          Icons.search, 
                          color: warmTangerine,
                          size: 22,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Icon(
                  Icons.tune_rounded, 
                  color: warmTangerine,
                  size: 28,
                ),
              ],
            ),
          ),

          // Body / Empty State
          Expanded(
            child: _restaurants.isEmpty
                ? const _EmptyState()
                : _RestaurantList(restaurants: _restaurants),
          ),
        ],
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
          Icon(
            Icons.storefront_outlined,
            size: 72,
            color: const Color(0xFFF47B42).withOpacity(0.25),
          ),
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

class _RestaurantList extends StatelessWidget {
  final List<Map<String, dynamic>> restaurants;
  const _RestaurantList({required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: restaurants.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final resto = restaurants[index];
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF0E8E2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            resto['name'] ?? 'Restaurant',
            style: const TextStyle(
              fontFamily: 'Afacad', 
              fontSize: 15,
              color: Color(0xFF5A3E2B),
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
    );
  }
}