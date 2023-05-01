import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:acamedia/helper/helper_functions.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class DMpage extends StatefulWidget {
  final String user2Name;
  final String user2ID;
  const DMpage({super.key, required this.user2Name, required this.user2ID});

  @override
  State<DMpage> createState() => _DMpageState();
}

class _DMpageState extends State<DMpage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(widget.user2Name, style: TextStyle(color: Colors.white, fontSize: 22),),
        actions: [
          // IconButton(onPressed: (){}, icon: Icon(Icons.call, color: Colors.white)),
          ZegoSendCallInvitationButton(
          isVideoCall: true,
          resourceID: "zegouikit_call",    // For offline call notification
          invitees: [
            ZegoUIKitUser(
              id: widget.user2ID,
              name: widget.user2Name,
            ),
   ],
)
          
        ],
      ),
    );
  }
}
