// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//main file

import 'package:acamedia/helper/helper_functions.dart';
import 'package:acamedia/pages/auth/login.dart';
import 'package:acamedia/pages/auth/register.dart';
import 'package:acamedia/pages/constants.dart';
import 'package:acamedia/pages/home.dart';
import 'package:acamedia/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final navigatorKey = GlobalKey<NavigatorState>();

  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  runApp(MyApp(navigatorKey: navigatorKey));

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

  // ZegoUIKit().initLog().then((value) {
  //   ///  Call the `useSystemCallingUI` method
  //   ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
  //     [ZegoUIKitSignalingPlugin()],
  //   );
  // }
}

class MyApp extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  const MyApp({
    required this.navigatorKey,
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  String myName = "";
  String myID = "";
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

    await helperFunctions.getUserNameSF().then((value) {
      myName = value!;
    });

    await helperFunctions.getUserIDSF().then((value) {
      myID = value!;
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.navigatorKey,
      debugShowCheckedModeBanner: false,
      home: _isLoggedIn ? homePage() : loginPage(),
    );
  }
}
