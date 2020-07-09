import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/textFieldFormaters.dart';
import 'package:mollet/widgets/allWidgets.dart';

class EditProfile extends StatefulWidget {
  final UserDataProfile user;
  EditProfile(this.user);

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
      print(_error);
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
        Text(
          "Profile",
          style: boldFont(MColors.primaryPurple, 18.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        <Widget>[
          FlatButton(
            onPressed: () {
              _submit();
            },
            child: Text(
              "Save",
              style: boldFont(MColors.textDark, 16.0),
            ),
          )
        ],
      ),
      body: primaryContainer(
        SingleChildScrollView(
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
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
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
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        child: Text(
                                          "Email",
                                          style: GoogleFonts.montserrat(
                                            color: MColors.textGrey,
                                            fontSize: 13.0,
                                          ),
                                        ),
                                      ),
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
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      "Phone",
                                      style: GoogleFonts.montserrat(
                                        color: MColors.textGrey,
                                        fontSize: 13.0,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: user.phone,
                                      inputFormatters: [maskTextInputFormatter],
                                      autocorrect: true,
                                      textAlign: TextAlign.end,
                                      enableSuggestions: true,
                                      autovalidate: _autoValidate,
                                      onSaved: (val) => _phone = val,
                                      validator: PhoneNumberValiditor.validate,
                                      keyboardType: TextInputType.phone,
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
      ),
    );
  }
}
