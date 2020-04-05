import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';
import 'package:mollet/screens/register_screens/registration_screen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/strings.dart';

class IntroScreen extends StatelessWidget {
  Widget buildOnboard() {
    return Expanded(
      flex: 1,
      child: Container(
        // color: MColors.primaryWhiteSmoke,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                "assets/images/pets.svg",
                height: 250,
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Container(
              padding: const EdgeInsets.only(right: 50.0, left: 50.0),
              child: Column(
                children: <Widget>[
                  Text(
                    Strings.onBoardTitle1,
                    style: GoogleFonts.montserrat(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: MColors.textDark),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    Strings.onBoardTitle2,
                    style: GoogleFonts.montserrat(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: MColors.textDark,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                Strings.onBoardTitle_sub1,
                style: GoogleFonts.montserrat(
                  fontSize: 19.0,
                  color: MColors.textGrey,
                  height: 1.30,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIntro(BuildContext context) {
    return Column(
      children: <Widget>[
        buildOnboard(),
        Container(
          color: MColors.primaryWhite,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    Strings.signin_small,
                    style: GoogleFonts.montserrat(
                        color: MColors.primaryWhite,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 60.0,
                child: RawMaterialButton(
                  fillColor: MColors.primaryWhiteSmoke,
                  elevation: 0.0,
                  hoverElevation: 0.0,
                  focusElevation: 0.0,
                  highlightElevation: 0.0,
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => RegistrationScreen(),
                      ),
                    );
                  },
                  child: Text(
                    Strings.register,
                    style: GoogleFonts.montserrat(
                        color: MColors.primaryPurple,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      body: buildIntro(context),
    );
  }
}
