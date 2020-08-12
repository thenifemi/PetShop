import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

// import 'dart:async';
// import 'dart:io';

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
    return primaryContainer(
      ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, i) {
            return Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/footprint.png",
                          height: 90,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MColors.dashPurple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget noNotifications() {
    return emptyScreen(
      "assets/images/noInbox.svg",
      "No Notifications",
      "Messages, promotions and general information from stores, pet news and the Pet Shop team will show up here.",
    );
  }
}
