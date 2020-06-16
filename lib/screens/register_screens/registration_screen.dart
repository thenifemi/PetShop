import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/strings.dart';
import 'package:mollet/widgets/provider.dart';
import 'package:provider/provider.dart';

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

  void _submit(profile) async {
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
        String uid =
            await auth.createUserWithEmailAndPassword(_password, profile);
        UserManagement().storeNewUser(profile);
        print("Signed Up with new $uid");

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => LoginScreen(),
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

  Widget buildRegisterButton() {
    if (_state == 0) {
      return Text(
        "Next step",
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

  Widget registerButton(profile) {
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
          onPressed: _isButtonDisabled ? null : () => _submit(profile),
          child: buildRegisterButton(),
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
    var profile;
    return ChangeNotifierProvider<UserDataProfileNotifier>(
      create: (BuildContext context) => UserDataProfileNotifier(),
      child: Scaffold(
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
                    style: GoogleFonts.montserrat(
                        fontSize: 38.0,
                        color: MColors.textDark,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Text(
                          "Already have an account?",
                          style: GoogleFonts.montserrat(
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
                              formKey.currentState.reset();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => LoginScreen(),
                                ),
                              );
                            },
                            child: Text(
                              "Sign in!",
                              style: GoogleFonts.montserrat(
                                fontSize: 17.0,
                                color: MColors.primaryPurple,
                              ),
                              textAlign: TextAlign.start,
                            )),
                      ),
                    ],
                  ),
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
                              style: GoogleFonts.montserrat(
                                  color: MColors.textGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (val) => _name = val,
                              validator: NameValiditor.validate,
                              decoration: InputDecoration(
                                labelText: "e.g Remiola",
                                labelStyle:
                                    GoogleFonts.montserrat(fontSize: 16.0),
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
                              "Email",
                              style: GoogleFonts.montserrat(
                                  color: MColors.textGrey),
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
                              style: GoogleFonts.montserrat(
                                  color: MColors.textGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              autovalidate: _autoValidate,
                              validator: PasswordValiditor.validate,
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
                      Container(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Text(
                          "Your password must have 6 or more characters, a capital letter and must contain at least one number.",
                          style: GoogleFonts.montserrat(
                              color: MColors.primaryPurple),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Phone number",
                              style: GoogleFonts.montserrat(
                                  color: MColors.textGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            child: TextFormField(
                              autovalidate: _autoValidate,
                              keyboardType: TextInputType.numberWithOptions(),
                              validator: PhoneNumberValiditor.validate,
                              onSaved: (val) => _phoneNumber = val,
                              decoration: InputDecoration(
                                labelText: "e.g +55 47 12345-6789",
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
                          Container(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: Text(
                              "Your number should contain your country code and state code.",
                              style: GoogleFonts.montserrat(
                                  color: MColors.primaryPurple),
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
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      "By continuing, you agree to our Terms of Service.",
                                      style: GoogleFonts.montserrat(
                                          color: MColors.textDark),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.0),
                          registerButton(profile),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
