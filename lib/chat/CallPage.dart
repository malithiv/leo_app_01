import 'package:flutter/material.dart';
import 'package:zego_zimkit/zego_zimkit.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

class CallPage extends StatelessWidget {
  final String callID;
  final ZegoUIKitPrebuiltCallConfig config;

  const CallPage({
    Key? key,
    required this.callID,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID: 1498216675, // your appid
      appSign: 'eeb04730daf961e14110c9a65bc35dae40222e319774bbf584776c4c497927f9', // Replace with your ZEGOCLOUD appSign.
      userID: 'user_id', // Replace with a unique user ID.
      userName: 'user_name', // Replace with the user's name.
      callID: callID,
      config: config,
    );
  }
}
