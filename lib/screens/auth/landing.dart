import 'package:flutter/material.dart';
import 'package:kaon_sa_kuan/backend/services/auth_service.dart';
import 'package:kaon_sa_kuan/screens/admin/admin_main_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const Color warmTangerine = Color(0xFFF47B42); 

  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscure   = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email    = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showSnack('Please enter your credentials.');
      return;
    }

    setState(() => _isLoading = true);
    final user = await AuthService().signInAdmin(email, password);

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminMainScreen()), 
      );
    } else {  
      _showSnack('Invalid email or password.');
    }
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontFamily: 'Afacad')),
        backgroundColor: const Color(0xFF5A3E2B),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: warmTangerine, 
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/pig_mascot.png',
                  height: 180,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                
                const Text(
                  'Kaon sa Kuan',
                  style: TextStyle(
                    fontFamily: 'AdlamDisplay',
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                _InputField(
                  controller: _emailController,
                  hintText: 'username',
                ),
                const SizedBox(height: 15),
                _InputField(
                  controller: _passwordController,
                  hintText: 'password',
                  obscureText: _obscure,
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => _obscure = !_obscure),
                    child: Icon(
                      _obscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey.shade400,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 140,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: Colors.black45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2, color: warmTangerine),
                          )
                        : const Text(
                            'login',
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 20,
                              color: warmTangerine,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const _InputField({
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(fontFamily: 'Afacad', fontSize: 16),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Afacad',
            color: Colors.grey.shade400,
            fontSize: 18,
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: InputBorder.none,
        ),
      ),
    );
  }
}