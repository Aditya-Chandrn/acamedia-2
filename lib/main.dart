// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//main file

import 'package:acamedia/helper/helper_functions.dart';
import 'package:acamedia/pages/auth/login.dart';
import 'package:acamedia/pages/auth/register.dart';
import 'package:acamedia/pages/home.dart';
import 'package:acamedia/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  bool _isLoggedIn = false;
  void initState() {
    super.initState();
    getUserStatus();
  }

  getUserStatus() async {
    await helperFunctions.getUserStatusSF().then((value) {
      if (value != null) {
        setState(() {
        _isLoggedIn = value;
          
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn? homePage() : loginPage(),
    );
  }
}
