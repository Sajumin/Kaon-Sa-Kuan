import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'admin_homepage.dart'; 
import 'admin_reports.dart';
import 'admin_post.dart';


class AdminApprovals extends StatelessWidget {
  const AdminApprovals({super.key});
  final Color citrusOrange = const Color(0xFFF05A28);
  final Color citrusGreen = const Color(0xFF8BC34A);
  final Color darkBrown = const Color(0xFF3B2F2F);
  final Color creamBase = const Color(0xFFFFF3D6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8BC349),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF3A2F2E)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Text(
          'approval page goes here',
          style: GoogleFonts.dmSans(
            fontSize: 20,
            color: const Color(0xFF3A2F2E),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
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
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminHomepage()));
              break; 
            case 1:
              //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AdminApprovals()));
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
}