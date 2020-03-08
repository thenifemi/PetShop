import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({Key key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      body: SingleChildScrollView(
        // height: double.infinity,
        // color: MColors.primaryWhiteSmoke,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 75.0),
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
                            color: MColors.primaryPurple,
                          ),
                          textAlign: TextAlign.start,
                        )),
                  ),
                ],
              ),

              SizedBox(
                height: 20.0,
              ),

              //FORM
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Name",
                            style: TextStyle(color: MColors.textGrey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "e.g Remiola",
                              labelStyle: TextStyle(fontSize: 16.0),
                              contentPadding: new EdgeInsets.symmetric( horizontal: 25.0),
                              fillColor: MColors.primaryWhite,
                              filled: true,
                              hasFloatingPlaceholder: false,
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                              ),
                              focusedBorder: InputBorder.none,
                            ),
                            style: TextStyle(fontSize: 20.0, color: MColors.textDark),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Email",
                            style: TextStyle(color: MColors.textGrey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextFormField(
                            validator: (val) =>
                                !val.contains("@") ? 'Invalid Email' : null,
                            onSaved: (val) => _email = val,
                            decoration: InputDecoration(
                                labelText: "e.g Remiola2034@gmail.com",
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 10.0),
                                fillColor: MColors.primaryWhite,
                                hasFloatingPlaceholder: false,
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Password",
                            style: TextStyle(color: MColors.textGrey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: TextFormField(
                            validator: (val) => val.length < 6
                                ? 'Password not strong enough'
                                : null,
                            onSaved: (val) => _password = val,
                            decoration: InputDecoration(
                                labelText: "",
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 10.0),
                                fillColor: MColors.primaryWhite,
                                hasFloatingPlaceholder: false,
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "Your password must have 6 or more characters and your password must contain at least one number.",
                        style: TextStyle(color: MColors.primaryPurple),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            "Phone number",
                            style: TextStyle(color: MColors.textGrey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextFormField(
                            validator: (val) => !val.contains("47")
                                ? 'Invalid Phone number'
                                : null,
                            onSaved: (val) => _phoneNumber = val,
                            decoration: InputDecoration(
                                labelText: "e.g 47-99875-2365",
                                contentPadding: new EdgeInsets.symmetric(
                                    vertical: 13.0, horizontal: 10.0),
                                fillColor: MColors.primaryWhite,
                                hasFloatingPlaceholder: false,
                                filled: true,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
