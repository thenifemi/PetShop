import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/main.dart';
import 'package:mollet/screens/register_screens/registration_screen.dart';
import 'package:mollet/screens/register_screens/reset_screen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';
import 'package:mollet/widgets/provider.dart';

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
  String _error;
  bool _autoValidate = false;
  var _state = 0;
  bool _isButtonDisabled = false;

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void animateButton() {
    setState(() {
      _state = 1;
      _isButtonDisabled = true;
    });
  }

  void _submit() async {
    final form = formKey.currentState;

    try {
      final auth = MyProvider.of(context).auth;
      if (form.validate()) {
        form.save();
        setState(() {
          if (_state == 0) {
            animateButton();
          }
        });
        String uid = await auth.signInWithEmailAndPassword(_email, _password);
        print("Signed in with $uid");
        Navigator.of(context).pop();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => MyApp(),
          ),
        );
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.message;
        _state = 0;
        _isButtonDisabled = false;
      });

      print(e);
    }
  }

  Widget buildLoginButton() {
    if (_state == 0) {
      return Text(
        "Sign in",
        style: GoogleFonts.montserrat(
            color: MColors.primaryWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(MColors.primaryWhite),
      );
    } else {
      return null;
    }
  }

  Widget loginButton() {
    if (_isButtonDisabled == true) {
      return SizedBox(
        width: double.infinity,
        height: 60.0,
        child: RawMaterialButton(
          elevation: 0.0,
          hoverElevation: 0.0,
          focusElevation: 0.0,
          highlightElevation: 0.0,
          fillColor: MColors.primaryPurple,
          onPressed: null,
          child: buildLoginButton(),
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
          child: buildLoginButton(),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
      );
    }
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
                style: GoogleFonts.montserrat(
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
              ),
            ),

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
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  Strings.login_to_account,
                  style: GoogleFonts.montserrat(
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
                      style: GoogleFonts.montserrat(
                        fontSize: 17.0,
                        color: MColors.textGrey,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: FlatButton(
                        onPressed: () {
                          formKey.currentState.reset();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => RegistrationScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Create it!",
                          style: GoogleFonts.montserrat(
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
                            style:
                                GoogleFonts.montserrat(color: MColors.textGrey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                              labelStyle:
                                  GoogleFonts.montserrat(fontSize: 16.0),
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
                            style: GoogleFonts.montserrat(
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
                            style:
                                GoogleFonts.montserrat(color: MColors.textGrey),
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
                              suffix: SizedBox(
                                height: 20.0,
                                width: 35.0,
                                child: RawMaterialButton(
                                  onPressed: _toggle,
                                  child: new Text(
                                    _obscureText ? "Show" : "Hide",
                                    style: TextStyle(
                                      color: MColors.primaryPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
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
                            obscureText: _obscureText,
                            style: GoogleFonts.montserrat(
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
                              style: GoogleFonts.montserrat(
                                  color: MColors.textDark),
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
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => ResetScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot password?",
                          style:
                              GoogleFonts.montserrat(color: MColors.textGrey),
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
