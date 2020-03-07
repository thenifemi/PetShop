import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
            Navigator.of(context).pushNamed("/Welcome");
          },
        ),
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/Login");
            },
            child: Text(
              "Sign in",
              style: TextStyle(color: MColors.primaryPurple, fontSize: 16.0),
            ),
          )
        ],
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
                    "assets/images/phone_number.svg",
                    height: 160,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    Strings.registraionTitle,
                    style: TextStyle(
                        color: MColors.textDark,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 60.0, left: 60.0, bottom: 20.0),
                  child: Text(
                    Strings.registraionTitle_sub,
                    style: TextStyle(
                      color: MColors.textGrey,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w300,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
                Card(
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
                            onPressed: () {
                              Navigator.of(context).pushNamed("/Verification");
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
                      ],
                    ),
                  ),
                  elevation: 0.20,
                  borderOnForeground: false,
                  semanticContainer: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
