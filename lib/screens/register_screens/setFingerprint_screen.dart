import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';

class SetFingerprintScreen extends StatefulWidget {
  SetFingerprintScreen({Key key}) : super(key: key);

  @override
  _SetFingerprintScreenState createState() => _SetFingerprintScreenState();
}

class _SetFingerprintScreenState extends State<SetFingerprintScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: FlatButton(
          child: Icon(
            Icons.arrow_back_ios,
            color: MColors.textDark,
            size: 20.0,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed("/SetPassword");
          },
        ),
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
      ),
      body: Container(
        height: double.infinity,
        color: MColors.primaryWhiteSmoke,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  child: SvgPicture.asset(
                    "assets/images/fingerprint.svg",
                    height: 160,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    Strings.fingerprintTitle,
                    style: TextStyle(
                        color: MColors.textDark,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 60.0, left: 60.0, bottom: 20.0, top: 20.0),
                  child: Text(
                    Strings.fingerprintTitle_sub,
                    style: TextStyle(
                      color: MColors.textGrey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  padding: const EdgeInsets.only(
                    bottom: 30.0,
                  ),
                  child: Image.asset(
                    "assets/images/scan_fingerprint.png",
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: RawMaterialButton(
                    fillColor: MColors.primaryPurple,
                    onPressed: () {
                      Navigator.of(context).pushNamed("/Login");
                    },
                    child: Text(
                      Strings.conti_nue,
                      style: TextStyle(
                          color: MColors.primaryWhite, fontSize: 18.0),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
