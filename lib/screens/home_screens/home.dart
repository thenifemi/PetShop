// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mollet/model/auth/email_auth.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:mollet/utils/strings.dart';

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
                 SizedBox(height: 20.0),
                        SizedBox(
                          width: double.infinity,
                          height: 60.0,
                          child: RawMaterialButton(
                            elevation: 0.0,
                            hoverElevation: 0.0,
                            focusElevation: 0.0,
                            highlightElevation: 0.0,
                            fillColor: MColors.primaryPurple,
                            onPressed: () {
                              performLogout(context);
                            },
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  color: MColors.primaryWhite,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
