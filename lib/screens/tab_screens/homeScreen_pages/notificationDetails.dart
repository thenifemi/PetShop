import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class NotificationsDetails extends StatelessWidget {
  final Map<String, String> nots;
  final _isRead;
  NotificationsDetails(this.nots, this._isRead);

  @override
  Widget build(BuildContext context) {
    print(_isRead);
    return Scaffold(
      appBar: primaryAppBar(
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textGrey,
          ),
          onPressed: () {
            Navigator.pop(context, _isRead);
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
              nots['notificationTitle'],
              style: boldFont(MColors.textDark, 14.0),
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4.0),
                  height: 35,
                  child: Image.asset(
                    nots['senderAvatar'],
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
                  nots['senderName'],
                  style: normalFont(MColors.textDark, 14.0),
                ),
                Spacer(),
                Text(
                  nots['sentTime'],
                  style: normalFont(MColors.textGrey, 12.0),
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Text(
              nots['notificationBody'],
              style: normalFont(MColors.textDark, 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
