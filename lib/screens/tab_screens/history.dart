import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
                "assets/images/noHistory.svg",
                height: 150,
              ),
            ),
            Container(
              child: Text(
                "No history",
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
                "Your past orders, transactions and hires will show up here.",
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
