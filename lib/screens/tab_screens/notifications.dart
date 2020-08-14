import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mollet/screens/tab_screens/homeScreen_pages/notificationDetails.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class InboxScreen extends StatefulWidget {
  InboxScreen({Key key}) : super(key: key);

  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  var _isRead;
  String read;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String senderAvatar = "assets/images/footprint.png";
    String senderName = "Pet Shop Team";
    String sentTime = "11 Aug, 2020";
    String notificationTitle = "Order placed";
    String notificationBody =
        "Woof! Your order has been recieved by the Pet Shop, We will process everything for you. Sit back and relax. woof!";

    var nots = [
      {
        'senderAvatar': senderAvatar,
        'senderName': senderName,
        'sentTime': sentTime,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'notID': read
      },
      {
        'senderAvatar': senderAvatar,
        'senderName': senderName,
        'sentTime': sentTime,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'notID': read
      },
      {
        'senderAvatar': senderAvatar,
        'senderName': senderName,
        'sentTime': sentTime,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'notID': read
      },
      {
        'senderAvatar': senderAvatar,
        'senderName': senderName,
        'sentTime': sentTime,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'notID': read
      },
      {
        'senderAvatar': senderAvatar,
        'senderName': senderName,
        'sentTime': sentTime,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'notID': read
      },
      {
        'senderAvatar': senderAvatar,
        'senderName': senderName,
        'sentTime': sentTime,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'notID': read
      },
      {
        'senderAvatar': senderAvatar,
        'senderName': senderName,
        'sentTime': sentTime,
        'notificationTitle': notificationTitle,
        'notificationBody': notificationBody,
        'notID': read
      }
    ];
    return primaryContainer(
      ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: nots.length,
        itemBuilder: (context, i) {
          var not = nots[i];

          return GestureDetector(
            onTap: () async {
              var navigationResult = await Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => NotificationsDetails(nots[i], i),
                ),
              );
              print(navigationResult);
              setState(() {
                read = navigationResult;
              });
              print(not['notID']);
            },
            child: Container(
              decoration: BoxDecoration(
                color: read == "true"
                    ? MColors.primaryWhite
                    : MColors.primaryPlatinum,
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
                          not['senderAvatar'],
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
                        not['senderName'],
                        style: normalFont(MColors.textDark, 14.0),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            not['sentTime'],
                            style: normalFont(MColors.textGrey, 12.0),
                          ),
                          SizedBox(width: 5.0),
                          read == "true"
                              ? Container()
                              : Container(
                                  height: 8.0,
                                  width: 8.0,
                                  padding: EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                    color: MColors.primaryPurple,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    not['notificationTitle'],
                    style: boldFont(MColors.textDark, 14.0),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    not['notificationBody'],
                    style: normalFont(MColors.textDark, 13.0),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    "$i days ago",
                    style: normalFont(MColors.primaryPurple, 12.0),
                  ),
                ],
              ),
            ),
          );
        },
      ),
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
