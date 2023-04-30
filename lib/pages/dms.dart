import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

// class DMs extends StatelessWidget {
//   const DMs({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DMpage(),
//     );
//   }
// }

class DMpage extends StatelessWidget {
  const DMpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Container(
                // width: double.infinity,
                child: Row(
                  children: [
                    Container(child: Icon(Icons.circle_outlined)),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Container(
                        child: Text("Cheeku")),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 230, right: 5),
                child: IconButton(onPressed: (){},
                icon: Icon(Icons.call)),
              ),
            ],
          )
        ],
      ),
    );
  }
}