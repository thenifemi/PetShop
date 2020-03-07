import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';
import 'package:mollet/widgets/button_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: MColors.primaryPurple,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200.0,
              ),
              Container(
                child: SvgPicture.asset(
                  "assets/images/wallet.svg",
                  height: 230,
                  width: 100,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              Text(
                Strings.welcomeTitle,
                style: TextStyle(
                    color: MColors.primaryWhite,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 70.0,
                  left: 70.0,
                ),
                child: Text(
                  Strings.welcomeTitle_sub,
                  style: TextStyle(
                    color: MColors.primaryWhite,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w300,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              SizedBox(
                width: double.infinity,
                height: 50.0,
                child: RawMaterialButton(
                  fillColor: MColors.primaryWhite,
                  onPressed: () {
                    Navigator.of(context).pushNamed("/Login");
                  },
                  child: Text(
                    Strings.signin,
                    style: TextStyle(color: MColors.textDark, fontSize: 16.0),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/Registration");
                },
                child: Text(
                  Strings.register,
                  style: TextStyle(color: MColors.primaryWhite, fontSize: 16.0),
                ),
                color: MColors.primaryPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
