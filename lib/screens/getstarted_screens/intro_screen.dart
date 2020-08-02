import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';
import 'package:mollet/screens/register_screens/registration_screen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';
import 'package:mollet/widgets/allWidgets.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: primaryContainer(
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  "assets/images/pets.svg",
                  height: 200,
                ),
              ),
              SizedBox(height: 30.0),
              Container(
                child: Text(
                  "Welcome to Pet Shop",
                  style: boldFont(MColors.textDark, 30.0),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.0),
              Container(
                child: Text(
                  Strings.onBoardTitle_sub1,
                  style: normalFont(MColors.textGrey, 18.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 150.0,
        color: MColors.primaryWhite,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            primaryButtonPurple(
              Text(
                "Sign in",
                style: boldFont(MColors.primaryWhite, 16.0),
              ),
              () {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
                    builder: (_) => LoginScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            primaryButtonWhiteSmoke(
              Text(
                "Create an account",
                style: boldFont(MColors.primaryPurple, 16.0),
              ),
              () {
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(
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
