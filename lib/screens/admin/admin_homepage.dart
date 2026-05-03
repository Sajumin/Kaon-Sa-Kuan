import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_approval.dart';
import 'admin_reports.dart';
import 'admin_post.dart';

class AdminHomepage extends StatelessWidget {
  const  AdminHomepage({super.key});
  final Color citrusOrange = const Color(0xFFF05A28);
  final Color citrusGreen = const Color(0xFF8BC34A);
  final Color darkBrown = const Color(0xFF3B2F2F);
  final Color creamBase = const Color(0xFFFFF3D6);

  final List<Map<String, dynamic>> testRestaurants = const [
    {
      "name": "Manang Betch",
      "location": "CUB, Stall #2",
      "price": "Php 5 - Php 100",
      "tags": ["lunch", "chicken", "pork"],
      "image": "" 
    },
    {
      "name": "Vineyard",
      "location": "Brgy. Tacas, Miagao",
      "price": "Php 150 - Php 250",
      "tags": ["dinner", "beef", "fried"],
      "image": ""
    },
    {
      "name": "Beans and Bubbles",
      "location": "Brgy. Mat-y",
      "price": "Php 80 - Php 180",
      "tags": ["cafe", "coffee", "dessert"],
      "image": ""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 20, left: 5, right: 5, bottom: 5),
            decoration: BoxDecoration(
              color: citrusGreen,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Align(
                  alignment: Alignment.topRight,
                  child: //IconButton(
                    Icon(Icons.exit_to_app, color: Colors.black, size: 20),
                    //onPressed: () => Navigator.pop(context); 
                  //),
                ), 
                Text(
                  "Hello, Admin.",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                Text(
                  "What would you like to do today?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white
                  ),
                ),
              ],
            ),
          ),
          //Search Bar 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "search for restaurant...",
                prefixIcon: const Icon(Icons.search, color: Color.fromARGB(255, 16, 17, 16)),
                suffixIcon: const Icon(Icons.tune, color: Color.fromARGB(255, 5, 5, 5)),
                filled: true,
                fillColor: citrusGreen.withOpacity(0.7),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Restuarants List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: testRestaurants.length, // Placeholder count
              itemBuilder: (context, index) {
                return _buildRestaurantCard(testRestaurants[index]);
              },
            ),
          ),
        ],
      ),
      
      // navigation bar 
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkBrown,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        
        onTap: (index) {
          switch (index) {
            case 0:
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminHomepage()));
              break; 
            case 1:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminApprovals()));
              break;
            case 2:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminPost()));
              break;
            case 3:
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminReports()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'pending restos'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'add new'),
          BottomNavigationBarItem(icon: Icon(Icons.flag_outlined), label: 'view reports'),
        ],
      ),
    );
  }

  Widget _buildRestaurantCard(Map<String, dynamic> data) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: citrusOrange,
        borderRadius: BorderRadius.circular(35),
      ),
      child: Row(
        children: [
          // Black Circle Placeholder for Image
          const CircleAvatar(
            radius: 35,
            backgroundColor: Colors.black,
          ),
          const SizedBox(width: 15),
          // Info Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      data['name'] ?? "New Resto",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Row(
                      children: [
                        Icon(Icons.edit_note, size: 20),
                        Icon(Icons.delete_outline, size: 20),
                      ],
                    ),
                  ],
                ),
                Text("📍 ${data['location']}"),
                Text("💵 ${data['price']}"),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 5,
                  runSpacing: 5, // Adds spacing if tags wrap to a new line
                  children: (data['tags'] as List<String>)
                      .map((tag) => _buildTag(tag))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: citrusGreen,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}