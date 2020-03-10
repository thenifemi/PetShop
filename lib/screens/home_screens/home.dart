import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              "assets/images/pets.svg",
              height: 250,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 50.0, left: 50.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Welcome Home Cunt!",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: MColors.textDark),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
