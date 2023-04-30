// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'navBar.dart';
import 'package:acamedia/main.dart';

// class Calls extends StatelessWidget {
//   const Calls({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: callPage(),
//     );
//   }
// }

class callPage extends StatelessWidget {
  const callPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       drawer: navBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Calls"),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.logo_dev_outlined,
        //         color: Colors.white,
        //       )),
        // ],
        backgroundColor: Color.fromARGB(255, 32, 32, 32),
      ),
      body:Column(
        children: [
          Container(
            color: Color.fromARGB(255, 32, 32, 32),
            // child: myContainer(),
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey, fixedSize: Size(412, 75)),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 3),
                          child: Icon(Icons.call),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 3),
                          child: Text('Cheeku'),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(top: 7, left: 3),
                      child: Text(
                          "Hello Ma'am, I have a doubt.                                               19:05"),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
    ;
  }
}
