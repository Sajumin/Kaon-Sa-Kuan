import 'package:flutter/material.dart';
import 'screens/landing_page.dart';

void main() {
  runApp(const KaonSaKuanApp());
}

class KaonSaKuanApp extends StatelessWidget {
  const KaonSaKuanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kaon sa Kuan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8BC349)),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}