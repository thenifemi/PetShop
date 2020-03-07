import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';
import 'button_widgets.dart';

var registrationCard = Card(
  color: MColors.primaryWhite,
  child: Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      children: <Widget>[
        Form(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.phone_iphone),
              labelText: "Phone number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 20.0),
        SizedBox(
          width: double.infinity,
          height: 50.0,
          child: RawMaterialButton(
            fillColor: MColors.primaryPurple,
            onPressed: null,
            child: Text(
              Strings.conti_nue,
              style: TextStyle(color: MColors.primaryWhite, fontSize: 18.0),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    ),
  ),
  elevation: 0.60,
  borderOnForeground: false,
  semanticContainer: false,
  shape: RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(10.0),
  ),
);
