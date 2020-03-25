import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/widgets/provider.dart';

class ResetScreen extends StatefulWidget {
  ResetScreen({Key key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  bool _autoValidate = false;
  var _state = 0;
  bool _isButtonDisabled = false;
  String warning;

  void _showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            height: 330.0,
            color: MColors.primaryWhiteSmoke,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Reset link sent!",
                    style: GoogleFonts.montserrat(
                        fontSize: 30.0,
                        color: MColors.textDark,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.check_circle_outline,
                      color: Colors.green, size: 40.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30.0,
                    left: 30.0,
                    bottom: 20.0,
                  ),
                  child: Text(
                    "Please reset your password with the link sent to $_email and proceed to login.",
                    style: GoogleFonts.montserrat(
                      fontSize: 17.0,
                      color: MColors.textGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 30.0,
                    left: 30.0,
                    bottom: 10.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 60.0,
                    child: RawMaterialButton(
                      elevation: 0.0,
                      hoverElevation: 0.0,
                      focusElevation: 0.0,
                      highlightElevation: 0.0,
                      fillColor: MColors.primaryPurple,
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacementNamed("/home");
                      },
                      child: Text(
                        "Proceed to login",
                        style: GoogleFonts.montserrat(
                            color: MColors.primaryWhite,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
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
      final auth = Provider.of(context).auth;
      if (form.validate()) {
        form.save();
        setState(() {
          if (_state == 0) {
            animateButton();
          }
        });
        await auth.sendPasswordResetEmail(_email);
        print("Password reset link sent to $_email");
        _showModalSheet();
        _state = 0;
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    } catch (e) {
      setState(() {
        warning = e.message;
        _state = 0;
        _isButtonDisabled = false;
      });

      print(e);
    }
  }

  Widget buildResetButton() {
    if (_state == 0) {
      return Text(
        "Reset",
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

  Widget showAlert() {
    if (warning != null) {
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
                warning,
                style: GoogleFonts.montserrat(
                  color: Colors.redAccent,
                  fontSize: 15.0,
                ),
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
      return Container(
        height: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textDark,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed("/home");
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.only(top: 20.0),
                child: Text(
                  "Forgot password?",
                  style: GoogleFonts.montserrat(
                      fontSize: 38.0,
                      color: MColors.textDark,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  "Enter the email address associated with your account.",
                  style: GoogleFonts.montserrat(
                    fontSize: 17.0,
                    color: MColors.textGrey,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              SizedBox(
                height: 60.0,
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        autovalidate: _autoValidate,
                        validator: EmailValiditor.validate,
                        onSaved: (val) => _email = val,
                        decoration: InputDecoration(
                          labelText: "e.g Remiola2030@example.com",
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
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "We will send a link to reset your password to that email.",
                        style: GoogleFonts.montserrat(
                          color: MColors.textGrey,
                        ),
                      ),
                    ),
                    SizedBox(
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
                        child: buildResetButton(),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
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
