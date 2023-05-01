// ignore_for_file: prefer_const_constructors, camel_case_types

import 'package:acamedia/helper/helper_functions.dart';
import 'package:acamedia/pages/dms.dart';
import 'package:acamedia/service/db_ser.dart';
import 'package:acamedia/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class addChat extends StatefulWidget {
  const addChat({super.key});

  @override
  State<addChat> createState() => _addChatState();
}

class _addChatState extends State<addChat> {
  TextEditingController searchController = TextEditingController();
  bool _isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearched = false;
  String userName = "";
  String userEmail = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserNameandEmail();
  }

  getUserNameandEmail() async {
    await helperFunctions.getUserNameSF().then((value) {
      userName = value!;
    });

    await helperFunctions.getUserEmailSF().then((value) {
      userEmail = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Search"),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  controller: searchController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search to start a conversation...",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                )),
                GestureDetector(
                  onTap: () {
                    initiateSearchMethod();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                )
              : chatList(),
        ],
      ),
    );
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      await DatabaseService()
          .searchByName(searchController.text)
          .then((snapshot) {
        setState(() {
          searchSnapshot = snapshot;
          _isLoading = false;
          hasUserSearched = true;
        });
      });
    }
  }

  chatList() {
    return hasUserSearched
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              if (userName != searchSnapshot!.docs[index]['Name']) {
                return chatTile(searchSnapshot!.docs[index]['Name'],
                    searchSnapshot!.docs[index]['Email'], searchSnapshot!.docs[index]['UId']);
              } else {
                return Center(
                  child: Container(
                    child: Text("NO USER FOUND"),
                  ),
                );
              }
            },
          )
        : Container(
            child: Text("NO USER FOUND"),
          );
  }

  Widget chatTile(String userName, String userEmail, String u2ID) {
    // _isLoading = false;
    return GestureDetector(
      onTap: () {
        nextPage(context, DMpage(user2Name: userName,user2ID: u2ID));
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: Text(userName.substring(0, 1).toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 15))),
        title: Text(
          userName,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(userEmail),
      ),
    );
  }
}
