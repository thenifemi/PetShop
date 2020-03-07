import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              Navigator.of(context).pushNamed("/Registration");
            },
            child: Text(
              "Register",
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
                    "assets/images/login.svg",
                    height: 160,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    Strings.login_to_account,
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
                                  prefixIcon: Icon(Icons.phone_iphone),
                                  labelText: "Phone number",
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
                                  labelText: "Password",
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
                        SizedBox(height: 3.0),
                        SizedBox(
                          height: 20.0,
                          child: FlatButton(
                            onPressed: null,
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(color: MColors.primaryPurple),
                            ),
                            color: MColors.primaryWhite,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          width: double.infinity,
                          height: 50.0,
                          child: RawMaterialButton(
                            fillColor: MColors.primaryPurple,
                            onPressed: () {
                              Navigator.of(context).pushNamed("");
                            },
                            child: Text(
                              Strings.signin,
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
