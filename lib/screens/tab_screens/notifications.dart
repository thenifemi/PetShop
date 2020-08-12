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
          itemCount: 7,
          itemBuilder: (context, i) {
            return Container(
              decoration: BoxDecoration(
                color: MColors.primaryPlatinum,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(4.0),
                        height: 35,
                        child: Image.asset(
                          "assets/images/footprint.png",
                          height: 30,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MColors.primaryWhite,
                          border: Border.all(
                            color: MColors.primaryPurple,
                            width: 0.50,
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text(
                        "Pet Shop Team",
                        style: normalFont(MColors.textDark, 14.0),
                      ),
                      Spacer(),
                      Text(
                        "11 Aug, 2020",
                        style: normalFont(MColors.textGrey, 12.0),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Order placed",
                    style: boldFont(MColors.textDark, 14.0),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Woof! Your order has been recieved by the Pet Shop, We will process everything for you. Sit back and relax. woof!",
                    style: normalFont(MColors.textDark, 13.0),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "2 days ago",
                    style: normalFont(MColors.primaryPurple, 12.0),
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
