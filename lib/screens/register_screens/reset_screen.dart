import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petShop/screens/register_screens/login_screen.dart';
import 'package:petShop/utils/colors.dart';
import 'package:petShop/utils/textFieldFormaters.dart';
import 'package:petShop/widgets/allWidgets.dart';
import 'package:petShop/widgets/provider.dart';

class ResetScreen extends StatefulWidget {
  ResetScreen({Key key}) : super(key: key);

  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  String _email;
  String warning;
  bool _autoValidate = false;
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
      appBar: primaryAppBar(
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textDark,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        null,
        MColors.primaryWhiteSmoke,
        null,
        false,
        null,
      ),
      body: SingleChildScrollView(
        child: primaryContainer(
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 30.0),
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Forgot password?",
                  style: boldFont(MColors.textDark, 38.0),
                  textAlign: TextAlign.start,
                ),
              ),

              SizedBox(height: 10.0),

              showAlert(),

              SizedBox(height: 10.0),

              //FORM
              Form(
                key: formKey,
                autovalidate: _autoValidate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        "Enter the email address associated with your account.",
                        style: normalFont(MColors.textGrey, 16.0),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    primaryTextField(
                      null,
                      null,
                      "e.g Remiola2034@gmail.com",
                      (val) => _email = val,
                      true,
                      EmailValiditor.validate,
                      false,
                      _autoValidate,
                      true,
                      TextInputType.emailAddress,
                      null,
                      null,
                      0.50,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: Text(
                        "We will send a link to reset your password to that email.",
                        style: normalFont(MColors.primaryPurple, null),
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
                              "Reset password",
                              style: boldFont(
                                MColors.primaryWhite,
                                16.0,
                              ),
                            ),
                            _isButtonDisabled ? null : _submit,
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
                style: normalFont(Colors.red, 15),
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

  void _showModalSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          margin: EdgeInsets.only(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
            top: 5.0,
          ),
          padding: EdgeInsets.only(
            bottom: 15.0,
            left: 15.0,
            right: 15.0,
            top: 10.0,
          ),
          decoration: BoxDecoration(
            color: MColors.primaryWhiteSmoke,
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 20.0),
              Text(
                "Reset link sent!",
                style: boldFont(MColors.textDark, 26.0),
                textAlign: TextAlign.start,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.check_circle_outline,
                    color: Colors.green, size: 40.0),
              ),
              Text(
                "Please reset your password with the link sent to $_email and proceed to login.",
                style: normalFont(MColors.textGrey, 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              primaryButtonPurple(
                Text(
                  "Proceed to login",
                  style: boldFont(
                    MColors.primaryWhite,
                    16.0,
                  ),
                ),
                () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      builder: (_) => LoginScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _submit() async {
    final form = formKey.currentState;

    try {
      final auth = MyProvider.of(context).auth;
      if (form.validate()) {
        form.save();

        setState(() {
          _isButtonDisabled = true;
        });

        await auth.sendPasswordResetEmail(_email);
        print("Password reset link sent to $_email");

        _showModalSheet();
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    } catch (e) {
      setState(() {
        warning = e.message;
        _isButtonDisabled = false;
      });

      print("ERRORR ==>");
      print(e);
    }
  }
}
