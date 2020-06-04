import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msafiri/screens/login_screen.dart';
import 'package:msafiri/screens/dashboard_screen.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = Firestore.instance;

  // signUp
  static void signUpUser(
      BuildContext context, String name, String email, String password) async {
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      FirebaseUser signedInUser = authResult.user;
      if (signedInUser != null) {
        _firestore.collection('/users').document(signedInUser.uid).setData({
          'name': name,
          'email': email,
          'profileImageUrl': '',
        });
           
        Navigator.pushReplacementNamed(context, DashBoardScreen.id,arguments: {"name": name, "email": email},);
        print(name);
        print(email);
      }
    } catch (e) {
      print(e);
    } 
  }

//signOut
  static void logout(BuildContext context) {
    _auth.signOut();
     Navigator.pushReplacementNamed(context, LoginScreen.id);
  }

// login
  static void login(context, String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
        
      );
      if (user != null) {
        print(user);
           Navigator.pushReplacementNamed(context, DashBoardScreen.id,arguments: {"email": email},);
      }
    } catch (e) {
      print(e);
    }
  }

  // Reset Password
  static void sendPasswordResetEmail(context, String email) async {
    try {
      return _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e);
    }
  }
}
