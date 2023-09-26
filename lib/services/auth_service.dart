import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

sealed class AuthService {
  static final auth = FirebaseAuth.instance;

  static User get currentUser => auth.currentUser!;

  static Future<bool> signUp(
    String email,
    String password,
    String userName,
  ) async {
    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        userCredential.user!.updateDisplayName(userName);
      }

      return userCredential.user != null;
    } catch (e) {
      debugPrint('ERROR: $e');
      return false;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user != null;
    } catch (e) {
      debugPrint('ERROR: $e');
      return false;
    }
  }

  static Future<bool> signOut() async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      await auth.signOut();

      return true;
    } catch (e) {
      debugPrint('ERROR: $e');
      return false;
    }
  }

  static Future<bool> deleteAccount() async {
    try {
      if (auth.currentUser != null) {
        await auth.currentUser!.delete();

        return true;
      }

      return true;
    } catch (e) {
      debugPrint('ERROR: $e');
      return false;
    }
  }
}
