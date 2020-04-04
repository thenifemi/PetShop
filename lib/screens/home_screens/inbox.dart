import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';

class InboxScreen extends StatefulWidget {
  final inboxScreen;
  final ValueChanged<int> onPush;
  InboxScreen({this.inboxScreen, this.onPush});
  @override
  _InboxScreenState createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                "assets/images/noInbox.svg",
                height: 150,
              ),
            ),
            Container(
              child: Text(
                "No Inbox",
                style: GoogleFonts.montserrat(
                  color: MColors.textDark,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 30.0,
                left: 30.0,
                top: 10.0,
              ),
              child: Text(
                "Messages, promotions and general information from stores, petsitters and the Mollet team will show up here.",
                style: GoogleFonts.montserrat(
                  color: MColors.textGrey,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
