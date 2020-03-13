import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mollet/model/services/auth/email_auth.dart';
import 'package:mollet/model/services/user_management.dart';
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
  String _name;
  String _phoneNumber;
  String _error;
  bool _autoValidate = false;
  var _state = 0;
  bool _isButtonDisabled;

  void animateButton() {
    setState(() {
      _state = 1;
      _isButtonDisabled = true;
    });
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      setState(() {
        if (_state == 0) {
          animateButton();
        }
      });
      performRegistration(_email, _password, _name, context);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  Widget buildRegisterButton() {
    if (_state == 0) {
      return Text(
        "Next step",
        style: TextStyle(
            color: MColors.primaryWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(MColors.primaryPurple),
      );
    } else {
      return null;
    }
  }

  Widget registerButton() {
    if (_isButtonDisabled == true) {
      return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: RawMaterialButton(
        elevation: 0.0,
        hoverElevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        fillColor: MColors.textGrey,
        onPressed: null,
        child: buildRegisterButton(),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
      ),
    );
    } else {
 return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: RawMaterialButton(
        elevation: 0.0,
        hoverElevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        fillColor: MColors.primaryPurple,
        onPressed: _isButtonDisabled ? null : _submit,
        child: buildRegisterButton(),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
      ),
    );
    }
  }

  void performRegistration(_email, _password, _name, context) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: _email,
      password: _password,
    )
        .then((signedInUser) {
      // FirebaseUser user;
      var userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = _name;
      UserManagement().storeNewUser(signedInUser.user, _name, context);
      Navigator.of(context).pushReplacementNamed("/Homescreen");
    }).catchError((e) {
      setState(() {
        _error = e.message;
        _state = 0;
        _isButtonDisabled = false;
      });

      print(e);
    });
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.error_outline,
                color: Colors.redAccent,
              ),
            ),
            Expanded(
              child: Text(
                _error,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 5.0),
            //   child: IconButton(
            //     icon: Icon(Icons.close),
            //     onPressed: () {
            //       setState(() {
            //         _error = null;
            //       });
            //     },
            //     color: MColors.primaryPurple,
            //   ),
            // ),
          ],
        ),
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: MColors.primaryWhiteSmoke,
          border: Border.all(width: 1.0, color: Colors.redAccent),
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      body: SingleChildScrollView(
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
                        onTap: () {
                          Navigator.of(context).pushNamed("/Login");
                        },
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
                height: 10.0,
              ),
              showAlert(),

              SizedBox(
                height: 20.0,
              ),

              //FORM
              Form(
                key: formKey,
                autovalidate: _autoValidate,
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
                            onSaved: (val) => _name = val,
                            validator: NameValiditor.validate,
                            decoration: InputDecoration(
                              labelText: "e.g Remiola",
                              labelStyle: TextStyle(fontSize: 16.0),
                              contentPadding:
                                  new EdgeInsets.symmetric(horizontal: 25.0),
                              fillColor: MColors.primaryWhite,
                              filled: true,
                              hasFloatingPlaceholder: false,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                            ),
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(
                                fontSize: 17.0, color: MColors.textDark),
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
                            enableSuggestions: true,
                            autovalidate: _autoValidate,
                            validator: EmailValiditor.validate,
                            onSaved: (val) => _email = val,
                            decoration: InputDecoration(
                              labelText: "e.g Remiola2034@gmail.com",
                              labelStyle: TextStyle(fontSize: 16.0),
                              contentPadding:
                                  new EdgeInsets.symmetric(horizontal: 25.0),
                              fillColor: MColors.primaryWhite,
                              hasFloatingPlaceholder: false,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 17.0, color: MColors.textDark),
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
                            autovalidate: _autoValidate,
                            validator: PasswordValiditor.validate,
                            onSaved: (val) => _password = val,
                            decoration: InputDecoration(
                              labelText: "",
                              contentPadding:
                                  new EdgeInsets.symmetric(horizontal: 25.0),
                              fillColor: MColors.primaryWhite,
                              hasFloatingPlaceholder: false,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                            ),
                            obscureText: true,
                            style: TextStyle(
                                fontSize: 17.0, color: MColors.textDark),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Text(
                        "Your password must have 6 or more characters, a capital letter and must contain at least one number.",
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
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: TextFormField(
                            autovalidate: _autoValidate,
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: (val) {
                              String pattern = r'(^(?:[+0]9)?[0-9]{13}$)';
                              RegExp regex2 = new RegExp(pattern);
                              print(val);
                              if (!regex2.hasMatch(val)) {
                                return "Enter a valid phone number";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) => _phoneNumber = val,
                            decoration: InputDecoration(
                              labelText: "e.g +55 47 12345-6789",
                              labelStyle: TextStyle(fontSize: 16.0),
                              contentPadding:
                                  new EdgeInsets.symmetric(horizontal: 25.0),
                              fillColor: MColors.primaryWhite,
                              hasFloatingPlaceholder: false,
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.red,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 0.0,
                                ),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 17.0, color: MColors.textDark),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            "Your number should contain your country code and state code.",
                            style: TextStyle(color: MColors.primaryPurple),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.verified_user,
                                color: MColors.primaryPurple,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                child: Text(
                                  "By continuing, you agree to our Terms of Service.",
                                  style: TextStyle(color: MColors.textDark),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.0),
                        registerButton(),
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
