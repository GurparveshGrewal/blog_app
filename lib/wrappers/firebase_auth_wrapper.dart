import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthWrapper {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User get currentUser => _firebaseAuth.currentUser!;

  Future<User?> signupWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return response.user;
    } catch (error) {
      log(error.toString());
      return null;
    }
  }

  Future<User?> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return response.user;
    } on FirebaseAuthException catch (error) {
      log(error.toString());
      return null;
    }
  }
}
