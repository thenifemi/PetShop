import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';

class SetPasswordScreen extends StatefulWidget {
  SetPasswordScreen({Key key}) : super(key: key);

  @override
  _SetPasswordScreenState createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
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
            Navigator.of(context).pushNamed("/Verification");
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
                    "assets/images/password.svg",
                    height: 160,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    Strings.set_your_password,
                    style: TextStyle(
                        color: MColors.textDark,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Card(
                  color: MColors.primaryWhite,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        Form(
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Password",
                                  suffixIcon: Icon(Icons.visibility),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12.0,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Confirm password",
                                  suffixIcon: Icon(Icons.visibility),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: RawMaterialButton(
                            fillColor: MColors.primaryPurple,
                            onPressed: () {
                              Navigator.of(context).pushNamed("/SetFingerprint");
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
