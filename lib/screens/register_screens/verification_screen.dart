import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen({Key key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  String _phoneNumber;
  bool _autoValidate = false;

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      Navigator.of(context).pushNamed("/Homescreen");

      // perfomLogin();
    } else {
      setState(() {
        _autoValidate = true;
      });
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
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.only(top: 100.0),
                child: Text(
                  "Enter the code",
                  style: TextStyle(
                      fontSize: 38.0,
                      color: MColors.textDark,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),

              Container(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  Strings.verificationTitle,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: MColors.textGrey,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),

              SizedBox(
                height: 60.0,
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
                        keyboardType: TextInputType.numberWithOptions(),
                        autovalidate: _autoValidate,
                        validator: (val) {
                          Pattern pattern = r'(?=.*?[0-9])';
                          RegExp regex = RegExp(pattern);
                          print(val);
                          if (val.length > 6 ||
                              (!regex.hasMatch(val)) ||
                              val.length < 3) {
                            return "Hmm! That doesn't seem right.";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (val) => _password = val,
                        decoration: InputDecoration(
                          labelText: "Enter the code",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 25.0),
                          fillColor: MColors.primaryWhite,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        style:
                            TextStyle(fontSize: 17.0, color: MColors.textDark),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "I didn't recieve the code",
                        style: TextStyle(
                          color: MColors.textGrey,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 30.0),
                      child: GestureDetector(
                        onTap: () {},
                        child: Text(
                          "RESEND",
                          style: TextStyle(
                            color: MColors.primaryPurple,
                            fontSize: 16.0,
                          ),
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
                        child: Text(
                          "Keep going",
                          style: TextStyle(
                              color: MColors.primaryWhite,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
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
