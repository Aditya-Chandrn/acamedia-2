// ignore_for_file: prefer_const_constructors

import 'package:acamedia/helper/helper_functions.dart';
import 'package:acamedia/pages/auth/register.dart';
import 'package:acamedia/pages/home.dart';
import 'package:acamedia/service/auth_ser.dart';
import 'package:acamedia/service/db_ser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

import '../../widgets/widgets.dart';
import '../constants.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String name = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blueGrey))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 25),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/Icon Comps.png",
                            width: 30,
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 9.0),
                            child: Text(
                              "AcaMedia",
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Text(
                  "Login to join other students and teachers.",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                // const Text(
                                //   "Login",
                                //   style: TextStyle(fontSize: 30, color: Colors.white),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 40.0, left: 20, right: 20),
                                  child: TextFormField(
                                    decoration: textInputDecoration.copyWith(
                                        labelText: "Email",
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Colors.white,
                                        )),
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (val) {
                                      email = val;
                                    },
                                    //validation
                                    validator: (val) {
                                      return RegExp(
                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                              .hasMatch(val!)
                                          ? null
                                          : "Please Enter a valid Email address";
                                    },
                                  ),
                                ),
                                SizedBox(height: 15),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20.0, left: 20, right: 20),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: textInputDecoration.copyWith(
                                        labelText: "Password",
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        )),
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (val) {
                                      password = val;
                                    },
                                    validator: (val) {
                                      if (val!.length < 8) {
                                        return "Enter a strong password (Atleast 8 characters.)";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(height: 25),
                                SizedBox(
                                  width: 160,
                                  height: 50,
                                  child: ElevatedButton.icon(
                                      onPressed: () {
                                        login();
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18))),
                                      icon: Icon(Icons.login),
                                      label: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w300),
                                      )),
                                ),
                                SizedBox(height: 10),
                                SizedBox(
                                  width: 160,
                                  height: 50,
                                  child: ElevatedButton.icon(
                                      onPressed: () {
                                        nextPage(context, registerPage());
                                      },
                                      style: ElevatedButton.styleFrom(
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18))),
                                      icon: Icon(Icons.login),
                                      label: Text(
                                        "Register",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w300),
                                      )),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                )
              ],
            ),
      backgroundColor: Color.fromARGB(255, 32, 32, 32),
    );
  }

  login() async {
    if (formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService.loginUser(email, password).then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .getData(email);
          await helperFunctions.saveLoginStatus(true);
          await helperFunctions.saveEmailSF(email);
          await helperFunctions.saveUserNameSF(snapshot.docs[0]['Name']);
          await helperFunctions.saveUserIDSF(snapshot.docs[0]['UId']);
          nextPageReplace(context, homePage());
          onUserLogin(snapshot.docs[0]['UId'], snapshot.docs[0]['Name']);
        } else {
          showSnackBar(context, Colors.red, value);
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  void onUserLogin(String myID, String myName) {
    /// 1.2.1. initialized ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged in or re-logged in
    /// We recommend calling this method as soon as the user logs in to your app.
    ZegoUIKitPrebuiltCallInvitationService().init(
      appID: MyConst.appID /*input your AppID*/,
      appSign: MyConst.appSign /*input your AppSign*/,
      userID: myID,
      userName: myName,
      plugins: [ZegoUIKitSignalingPlugin()],
    );
  }

  void onUserLogout() {
    /// 1.2.2. de-initialization ZegoUIKitPrebuiltCallInvitationService
    /// when app's user is logged out
    ZegoUIKitPrebuiltCallInvitationService().uninit();
  }
}
