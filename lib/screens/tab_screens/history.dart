import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return primaryContainer(
      Center(
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
                  "No Orders",
                  style: boldFont(MColors.textDark, 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Text(
                  "Your past orders, transactions and hires will show up here.",
                  style: normalFont(MColors.textGrey, 16),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
