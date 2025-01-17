import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jugyourogu/SelectLogin/register_or_login.dart';
import 'package:jugyourogu/SelectLogin/select_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart';

class AuthMethods {
  final googleSignIn = GoogleSignIn();

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future signOut(context) async {
    await googleSignIn.disconnect();
    // ここでキーを外す
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear().then((value) => auth.signOut().then((value) => {
          Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => const RegisterLoginScreen(),
                transitionDuration: const Duration(seconds: 0),
              ))
        }));
  }
}