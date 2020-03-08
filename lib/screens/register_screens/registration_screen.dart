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
      backgroundColor: MColors.primaryWhiteSmoke,
      body: Container(
        height: double.infinity,
        color: MColors.primaryWhiteSmoke,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 60.0),
                child: Text(
                  Strings.registraionTitle,
                  style: TextStyle(
                      fontSize: 38.0,
                      color: MColors.textDark,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      Strings.registraionTitle_sub,
                      style: TextStyle(
                        fontSize: 17.0,
                        color: MColors.textGrey,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(
                    width: 3.0,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Sign in!",
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.blue,
                          ),
                          textAlign: TextAlign.start,
                        )),
                  ),

                  //FORM
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
