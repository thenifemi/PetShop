import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/utils/colors.dart';

class EditProfile extends StatefulWidget {
  UserDataProfile user;
  EditProfile(this.user);

  // EditProfile({Key key, this.user}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState(user);
}

class _EditProfileState extends State<EditProfile> {
  UserDataProfile user;

  _EditProfileState(this.user);
  Future profileFuture;

  final formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String _name;
  String _phone;
  String _error;
  bool _autoValidate = false;

  void _submit() async {
    final form = formKey.currentState;

    try {
      if (form.validate()) {
        form.save();
        updateProfile(_name, _phone);
        Navigator.pop(context, true);
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.message;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return profile(user);
  }

  Widget profile(user) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MColors.primaryWhiteSmoke,
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: MColors.primaryWhite,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textDark,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Profile",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _submit();
            },
            child: Text(
              "Save",
              style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    child: SvgPicture.asset(
                      "assets/images/femaleAvatar.svg",
                      height: 150,
                    ),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: MColors.dashPurple,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                color: MColors.primaryWhite,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        "Name",
                                        style: GoogleFonts.montserrat(
                                          color: MColors.textGrey,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        initialValue: user.name,
                                        textAlign: TextAlign.end,
                                        enableSuggestions: true,
                                        autovalidate: _autoValidate,
                                        validator: NameValiditor.validate,
                                        onSaved: (val) => _name = val,
                                        decoration: InputDecoration(
                                          labelStyle: GoogleFonts.montserrat(
                                              color: MColors.primaryPurple,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.w500),
                                          contentPadding:
                                              new EdgeInsets.symmetric(
                                                  horizontal: 25.0),
                                          fillColor: MColors.primaryWhite,
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 0.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 0.0,
                                            ),
                                          ),
                                        ),
                                        style: GoogleFonts.montserrat(
                                            color: MColors.primaryPurple,
                                            fontSize: 13.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 1.0,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    // Expanded(
                                    Text(
                                      "Email",
                                      style: GoogleFonts.montserrat(
                                        color: MColors.textGrey,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                    // ),
                                    Expanded(
                                      child: TextFormField(
                                        textAlign: TextAlign.end,
                                        initialValue: user.email,
                                        enabled: false,
                                        // onSaved: (val) => _email = val,
                                        decoration: InputDecoration(
                                          labelStyle: GoogleFonts.montserrat(
                                            color: MColors.textGrey,
                                            fontSize: 13.0,
                                          ),
                                          contentPadding:
                                              new EdgeInsets.symmetric(
                                                  horizontal: 25.0),
                                          fillColor: MColors.primaryWhite,
                                          hasFloatingPlaceholder: false,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 0.0,
                                            ),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.red,
                                              width: 1.0,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide(
                                              color: Colors.white,
                                              width: 0.0,
                                            ),
                                          ),
                                        ),
                                        style: GoogleFonts.montserrat(
                                          color: MColors.textGrey,
                                          fontSize: 13.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              height: 1.0,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Phone",
                                  style: GoogleFonts.montserrat(
                                    color: MColors.textGrey,
                                    fontSize: 13.0,
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    initialValue: user.phone,
                                    textAlign: TextAlign.end,
                                    enableSuggestions: true,
                                    autovalidate: _autoValidate,
                                    validator: PhoneNumberValiditor.validate,
                                    onSaved: (val) => _phone = val,
                                    decoration: InputDecoration(
                                      labelStyle: GoogleFonts.montserrat(
                                          color: MColors.primaryPurple,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500),
                                      contentPadding: new EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      fillColor: MColors.primaryWhite,
                                      hasFloatingPlaceholder: false,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 0.0,
                                        ),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 1.0,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 0.0,
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.montserrat(
                                        color: MColors.primaryPurple,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
