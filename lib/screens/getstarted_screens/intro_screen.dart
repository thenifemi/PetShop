import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';
import 'package:mollet/screens/register_screens/registration_screen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/strings.dart';
import 'package:mollet/widgets/allWidgets.dart';

class IntroScreen extends StatelessWidget {
  Widget buildOnboard() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            child: SvgPicture.asset(
              "assets/images/pets.svg",
              height: 230,
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
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 10.0,
              bottom: 5.0,
            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      body: buildOnboard(),
      bottomNavigationBar: Container(
        height: 180.0,
        color: MColors.primaryWhite,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            primaryButtonPurple(
              Text(
                "Sign in",
                style: GoogleFonts.montserrat(
                    color: MColors.primaryWhite,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => LoginScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 15.0,
            ),
            primaryButtonWhiteSmoke(
              Text(
                "Create an account",
                style: GoogleFonts.montserrat(
                    color: MColors.primaryPurple,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => RegistrationScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
