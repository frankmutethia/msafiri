import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:msafiri/models/userInfo.dart';
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

        Navigator.pushReplacementNamed(
          context,
          DashBoardScreen.id,
          // arguments: {"name": name, "email": email},
        );
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
      print(user.user.displayName);
      if (user != null) {
        print(user);
        Navigator.pushReplacementNamed(
          context,
          DashBoardScreen.id,
          // arguments: {"email": email},
        );
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

  // user details from firestore
  static getUserDetailsFromFirestore() async {
    // 1. get user id
    String userID = await getUserId();
    // 2. fetch document using user id
    final userCollection = Firestore.instance.collection('users');
    // 3. Map the response to a dart model
    return userCollection.document(userID).get().then((DocumentSnapshot doc) {
      return User.fromSnapshot(doc);
    });
  }

  // is sign in
  static Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  // Note this is from firebaseuser
  // getUser func return user details such as
  // - displayName
  // - email address
  // - profile pic if exists
  static Future<FirebaseUser> getUser() async {
    var user = await _auth.currentUser();
    return user;
  }

  // get user id
  static Future<String> getUserId() async {
    return (await _auth.currentUser()).uid;
  }
}
