import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserHomepage extends StatelessWidget {
  const UserHomepage({super.key});

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
          'homepage goes here',
          style: GoogleFonts.dmSans(
            fontSize: 20,
            color: const Color(0xFF3A2F2E),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}