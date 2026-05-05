import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/screens/auth/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        textTheme: GoogleFonts.afacadTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const LandingPage(),
    );
  }
}
