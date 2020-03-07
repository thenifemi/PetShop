import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';

//WHITE SIGNIN BUTTON
var whiteSigninBtn = RawMaterialButton(
  fillColor: MColors.primaryWhite,
  onPressed: (null),
  child: Text(
    Strings.signin,
    style: TextStyle(color: MColors.textDark, fontSize: 16.0),
  ),
  shape: RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(10.0),
  ),
);

//PURPLE SIGNIN BUTTON
var purpleSigninBtn = FlatButton(
  onPressed: null,
  child: Text(
    Strings.signin,
    style: TextStyle(color: MColors.primaryWhite),
  ),
  color: MColors.primaryPurple,
  shape: RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(15.0),
  ),
);

//WHITE CONTINUE BUTTON (NOT USED AS AT TIME OF BUILD)
var whiteContinueBtn = FlatButton(
  onPressed: null,
  child: Text("Continue"),
  color: MColors.primaryWhite,
  shape: RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(18.0),
  ),
);

//PURPLE CONTINUE BUTTON
var purpleContinueBtn = RawMaterialButton(
  fillColor: MColors.primaryPurple,
  onPressed: null,
  child: Text(
    Strings.conti_nue,
    style: TextStyle(color: MColors.primaryWhite, fontSize: 18.0),
  ),
  shape: RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(10.0),
  ),
);

//WHITE REGISTER BUTTON
// var whiteRegisterBtn = FlatButton(
//   onPressed: () {
//     Navigator.of(context).pushNamed("/Registration");
//   },
//   child: Text(
//     Strings.register,
//     style: TextStyle(color: MColors.primaryWhite, fontSize: 16.0),
//   ),
//   color: MColors.primaryPurple,
// );

//PURPLE RESEND BUTTON
var purpleResendBtn = FlatButton(
  onPressed: null,
  child: Text(
    "Resend",
    style: TextStyle(color: MColors.primaryPurple),
  ),
  color: MColors.primaryWhite,
);

//PURPLE FORGOT PASSWORD BUTTON
var purpleForgotPasswordBtn = FlatButton(
  onPressed: null,
  child: Text(
    "Forgot password?",
    style: TextStyle(color: MColors.primaryPurple),
  ),
  color: MColors.primaryWhite,
);

//GREY SKIP BUTTON
var greySkipBtn = FlatButton(
  onPressed: null,
  child: Text(
    "Skip",
    style: TextStyle(color: MColors.textGrey),
  ),
  color: MColors.primaryWhite,
);

// GET STRATED BUTTON
var getStartedBtn = FlatButton(
  onPressed: null,
  child: Text(
    "Get started",
    style: TextStyle(color: MColors.textDark),
  ),
  color: MColors.primaryWhite,
  shape: RoundedRectangleBorder(
    borderRadius: new BorderRadius.circular(15.0),
  ),
);

//FINGERPRINT BUTTON
var fingerprintBtn = FlatButton(
  onPressed: null,
  child: SvgPicture.asset(
    "assets/images/fingerprint.svg",
  ),
  color: MColors.primaryWhite,
);
