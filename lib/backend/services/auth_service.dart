import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // For Guests: No UI, no password, just access
  Future<User?> signInAnonymously() async {
    try {
      // If a user is already "signed in" (even as a guest), return them
      if (_auth.currentUser != null) return _auth.currentUser;

      UserCredential result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      debugPrint("Silent login failed: $e");
      return null;
    }
  }

  // Admin login still needs credentials
  Future<User?> signInAdmin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      return null;
    }
  }
}
