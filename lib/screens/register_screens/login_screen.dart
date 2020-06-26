import 'package:flutter/material.dart';
import 'package:mollet/main.dart';
import 'package:mollet/screens/register_screens/registration_screen.dart';
import 'package:mollet/screens/register_screens/reset_screen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';
import 'package:mollet/utils/textFieldFormaters.dart';
import 'package:mollet/widgets/provider.dart';
import 'package:mollet/widgets/buttonsAndStuff.dart';

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
  bool _isButtonDisabled = false;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void animateButton() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  void _submit() async {
    final form = formKey.currentState;

    try {
      final auth = MyProvider.of(context).auth;
      if (form.validate()) {
        form.save();
        if (mounted) {
          setState(() {
            if (_isButtonDisabled = true) {
              animateButton();
            }
          });
        }

        String uid = await auth.signInWithEmailAndPassword(_email, _password);
        print("Signed in with $uid");
        // Navigator.of(context).pop();
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
      if (mounted) {
        setState(() {
          _error = e.message;
          _isButtonDisabled = false;
        });
      }

      print(e);
      print("ERRORRRRRRRRRRR");
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
                style: normalFont(Colors.redAccent, 15.0),
              ),
            ),
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
      return null;
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
                  style: boldFont(MColors.textDark, 38.0),
                  textAlign: TextAlign.start,
                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      Strings.do_not_have_account,
                      style: normalFont(MColors.textGrey, 16.0),
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
                          formKey.currentState.reset();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => RegistrationScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Create it!",
                          style: normalFont(MColors.primaryPurple, 16.0),
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
                            style: normalFont(MColors.textGrey, null),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: primaryTextField(
                            null,
                            "e.g Remiola2034@gmail.com",
                            (val) => _email = val,
                            EmailValiditor.validate,
                            false,
                            _autoValidate,
                            true,
                            TextInputType.emailAddress,
                            null,
                            null,
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
                            style: normalFont(MColors.textGrey, null),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: primaryTextField(
                            null,
                            "",
                            (val) => _password = val,
                            PasswordValiditor.validate,
                            _obscureText,
                            _autoValidate,
                            false,
                            TextInputType.text,
                            null,
                            SizedBox(
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
                              style: normalFont(MColors.textDark, null),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    _isButtonDisabled == true
                        ? primaryButtonPurple(
                            //if button is loading
                            progressIndicator(Colors.white),
                            null,
                          )
                        : primaryButtonPurple(
                            Text(
                              "Sign in",
                              style: boldFont(
                                MColors.primaryWhite,
                                16.0,
                              ),
                            ),
                            _isButtonDisabled ? null : _submit,
                          ),
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
                          style: normalFont(MColors.textGrey, null),
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
