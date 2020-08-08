import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

// import 'dart:async';
// import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({Key key}) : super(key: key);

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return emptyScreen(
      "assets/images/noInbox.svg",
      "No Notifications",
      "Messages, promotions and general information from stores, pet news and the Pet Shop team will show up here.",
    );
  }
}

class MessageHandler extends StatefulWidget {
  MessageHandler({Key key}) : super(key: key);

  @override
  _MessageHandlerState createState() => _MessageHandlerState();
}

class _MessageHandlerState extends State<MessageHandler> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}
