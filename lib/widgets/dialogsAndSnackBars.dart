import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSimpleSnack(
  String value,
  IconData icon,
  Color iconColor,
  GlobalKey<ScaffoldState> _scaffoldKey,
) {
  _scaffoldKey.currentState.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      duration: Duration(milliseconds: 1400),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      content: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.montserrat(),
            ),
          ),
          Icon(
            icon,
            color: iconColor,
          )
        ],
      ),
    ),
  );
}
