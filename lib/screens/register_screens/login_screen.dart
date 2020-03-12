import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final loginKey = GlobalKey<_LoginScreenState>();

  String _email;
  String _password;
  String _phoneNumber;
  String _error;

  bool _autoValidate = false;
  var _state = 0;

  void animateButton() {
    setState(() {
      _state = 1;
    });

    // Timer(Duration(milliseconds: 3300), () {
    //   setState(() {
    //     _state = 0;
    //   });
    // });
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
      performLogin(_email, _password, context);
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void performLogin(_email, _password, context) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: _email,
      password: _password,
    )
        .then((user) {
      Navigator.of(context).pushReplacementNamed("/Homescreen");
    }).catchError((e) {
      setState(() {
        _error = e.message;
        _state = 0;
      });

      print(e);
    });
  }

  Widget buildLoginButton() {
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
        valueColor: AlwaysStoppedAnimation<Color>(MColors.primaryWhite),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }

  Widget loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 60.0,
      child: RawMaterialButton(
        elevation: 0.0,
        hoverElevation: 0.0,
        focusElevation: 0.0,
        highlightElevation: 0.0,
        fillColor: MColors.primaryPurple,
        onPressed: () {
          _submit();
        },
        child: buildLoginButton(),
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        height: 60,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.error_outline,
              ),
            ),
            Expanded(
              child: Text(
                _error,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            ),
          ],
        ),
        color: Colors.redAccent,
        width: double.infinity,
        padding: const EdgeInsets.all(10.0),
      );
    } else {
      return Container(
        height: 30.0,
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
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  Strings.login_to_account,
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
                      Strings.do_not_have_account,
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
                          Navigator.of(context).pushNamed("/Registration");
                        },
                        child: Text(
                          "Create it!",
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
                            "Email",
                            style: TextStyle(color: MColors.textGrey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextFormField(
                            enableSuggestions: true,
                            autovalidate: _autoValidate,
                            validator: (val) {
                              print(val);
                              if (!val.contains("@") || !val.contains(".")) {
                                return "Enter a valid Email address";
                              } else if (val.isEmpty) {
                                return "Enter your Email address";
                              } else {
                                return null;
                              }
                            },
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
                            validator: (val) {
                              Pattern pattern =
                                  r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
                              RegExp regex = RegExp(pattern);
                              print(val);
                              if (val.length < 6 || (!regex.hasMatch(val))) {
                                return "Hmm! That doesn't seem right.";
                              } else {
                                return null;
                              }
                            },
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.check_box,
                            color: MColors.primaryPurple,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Container(
                            child: Text(
                              "Remember me.",
                              style: TextStyle(color: MColors.textDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    loginButton(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(color: MColors.textGrey),
                        ),
                      ),
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
