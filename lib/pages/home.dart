// ignore_for_file: prefer_const_constructors, camel_case_types

//Aditya

import 'package:acamedia/helper/helper_functions.dart';
import 'package:acamedia/pages/addChat.dart';
import 'package:acamedia/pages/auth/login.dart';
import 'package:acamedia/pages/dms.dart';
import 'package:acamedia/pages/search.dart';
import 'package:acamedia/pages/settings_page.dart';
import 'package:acamedia/service/auth_ser.dart';
import 'package:acamedia/service/db_ser.dart';
import 'package:acamedia/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'calls.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  AuthService authService = AuthService();
  Stream? chats;
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await helperFunctions.getUserEmailSF().then((value) {
      userEmail = value!;
    });
    await helperFunctions.getUserNameSF().then((val) {
      userName = val!;
    });

    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserChats()
        .then((snapshot) {
      setState(() {
        chats = snapshot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                accountName: Text(
                  userName,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                accountEmail: Text(
                  userEmail,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                // currentAccountPicture: CircleAvatar(
                //   child: ClipOval(
                //       child: Image.network(
                //     "https://helios-i.mashable.com/imagery/articles/00apgKgIAO4EnFfjOgCApRe/hero-image.fill.size_1248x702.v1619086604.jpg",
                //     fit: BoxFit.cover,
                //     width: 80,
                //     height: 80,
                //   )),
                // ),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 32, 32, 32),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.chat_bubble_sharp),
              title: Text("Chats",
                  style: TextStyle(color: Colors.black, fontSize: 15)),
              selected: true,
              selectedColor: Colors.black,
              onTap: () => {
                // nextPageReplace(context, homePage())
                Navigator.pop(context)
              },
            ),
            ListTile(
              leading: Icon(Icons.call),
              title: Text("Calls",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15)),
              onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => callPage(),
                    ))
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15)),
              onTap: () => {nextPage(context, settingsPage())},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout",
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15)),
              onTap: () async {
                showDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Logout"),
                        content: Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.cancel,
                                color: Colors.red,
                              )),
                          IconButton(
                              onPressed: () async {
                                await authService.signOut();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => loginPage()),
                                    (route) => false);
                              },
                              icon: Icon(
                                Icons.done,
                                color: Colors.green,
                              ))
                        ],
                      );
                    });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Chats"),
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
        actions: [
          IconButton(
              onPressed: () {
                nextPage(context, searchPage());
              },
              icon: Icon(
                Icons.search,
                color: Colors.white,
              )),
        ],
      ),
      body: chatList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // popupDialog(context);
          nextPage(context, addChat());
        },
        elevation: 0,
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  popupDialog(BuildContext context) {}
  chatList() {
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['Chats'] != null) {
            if (snapshot.data['Chats'].length != 0) {
              return Text("Hello");
            } else {
              return noChatWidget();
            }
          } else {
            return noChatWidget();
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
      },
    );
  }

  noChatWidget() {
    return Container(
      child: Center(
        child: Text("Tap the Search Icon to start a conversation."),
      ),
    );
  }
}
