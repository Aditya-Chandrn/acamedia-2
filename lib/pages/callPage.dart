import 'package:acamedia/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'constants.dart';

class CallPage extends StatelessWidget {
  final String callID;
  final String user2ID;
  final String user2Name;
  final String user2Email;
  const CallPage(
      {Key? key,
      required this.callID,
      required this.user2ID,
      required this.user2Name, required this.user2Email})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: MyConst
          .appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: MyConst
          .appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      userID: MyConst.myID,
      userName: MyConst.myName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (context) => Navigator.of(context).pop(),
    );
  }
}
