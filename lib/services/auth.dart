import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anonymously
  Future<void> signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User user = userCredential.user;
      return user;
    } catch(error) {
      debugPrint(error.toString());
      return null;
    }
  }

  // authentication change stream
  Stream<User> get user {
    return _auth.authStateChanges();
  }

  // sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}