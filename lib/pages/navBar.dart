import 'package:acamedia/pages/calls.dart';
import 'package:acamedia/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class navBar extends StatelessWidget {
  const navBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Container(
          //   child: Center(
          //     child: Text('AcaMedia',
          //     style: TextStyle(fontSize: 30), selectionColor: Colors.white,),
          //     ),
          //   color: Color.fromARGB(255, 32, 32, 32),
          //   height: 80,
          //   ),
            Padding(
              padding: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
              accountName: Text("Username"),
              accountEmail: Text("user@email.com"),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: Image.network("https://helios-i.mashable.com/imagery/articles/00apgKgIAO4EnFfjOgCApRe/hero-image.fill.size_1248x702.v1619086604.jpg", fit: BoxFit.cover,width: 80,height: 80,)
                ),
              ),
              decoration: BoxDecoration(color: Color.fromARGB(255, 32, 32, 32),),
              ),
            ),
        // ListTile(
        //   leading: Icon(Icons.account_circle_sharp),
        //   title: Text("Profile",
        //   style: TextStyle(fontSize: 20)),
        //   onTap: () => {},
        // ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text("Search",
          style: TextStyle(fontSize: 20)),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.chat_bubble_sharp),
          title: Text("Chats",
          style: TextStyle(fontSize: 20)),
          selected: true,
          selectedColor: Colors.blue,
          onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => homePage()))},
        ),
        ListTile(
          leading: Icon(Icons.call),
          title: Text("Calls",
          style: TextStyle(fontSize: 20)),
          onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => callPage(),))},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text("Settings",
          style: TextStyle(fontSize: 20)),
          onTap: () => {},
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app_outlined),
          title: Text("Exit",
          style: TextStyle(fontSize: 20)),
          onTap: () => {},
        ),
        ],
      ),
    );
  }
}