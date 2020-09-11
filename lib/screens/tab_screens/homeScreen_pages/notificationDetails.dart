import 'package:flutter/material.dart';
import 'package:petShop/utils/colors.dart';
import 'package:petShop/widgets/allWidgets.dart';

class NotificationsDetails extends StatelessWidget {
  final not;

  NotificationsDetails(
    this.not,
  );

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, true);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: primaryAppBar(
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: MColors.textGrey,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
          null,
          MColors.primaryWhiteSmoke,
          null,
          false,
          null,
        ),
        body: primaryContainer(
          Column(
            children: [
              Text(
                not.notificationTitle,
                style: boldFont(MColors.textDark, 14.0),
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4.0),
                    height: 35,
                    child: Image.asset(
                      not.senderAvatar,
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
                    not.senderName,
                    style: normalFont(MColors.textDark, 14.0),
                  ),
                  Spacer(),
                  Text(
                    not.sentTime,
                    style: normalFont(MColors.textGrey, 12.0),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                not.notificationBody,
                style: normalFont(MColors.textDark, 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
