// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mollet/model/services/auth/email_auth.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String usersName = " ";
  final DocumentReference documentReference =
      Firestore.instance.collection("users").document("name");

  _fetchUserName() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          usersName = datasnapshot.data['name'];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 75.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Hi,",
                      style: TextStyle(
                          fontSize: 38.0,
                          color: MColors.textDark,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  usersName == " "
                      ? Container(
                          child: Text(" "),
                        )
                      : Container(
                          child: Text(
                            usersName,
                            style: TextStyle(
                                fontSize: 38.0,
                                color: MColors.textDark,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "What would you like to do today?",
                style: TextStyle(
                    fontSize: 30.0,
                    color: MColors.textDark,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                "assets/images/pets.svg",
                height: 250,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Column(
                children: <Widget>[
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
                        // _fetchUserName();
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
      ),
    );
  }
}
