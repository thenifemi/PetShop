import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';

class EditProfile extends StatefulWidget {
  EditProfile({Key key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Navigator.of(context).pushReplacementNamed("/home");
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
            onPressed: () {},
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
      body: Column(
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
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: RawMaterialButton(
                        onPressed: () {},
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
                              child: Text(
                                "Oluwatimilehin Diffu",
                                style: GoogleFonts.montserrat(
                                    color: MColors.primaryPurple,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
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
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Email",
                                style: GoogleFonts.montserrat(
                                  color: MColors.textGrey,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "thenifemi@gmail.com",
                                style: GoogleFonts.montserrat(
                                  color: MColors.textGrey,
                                  fontSize: 13.0,
                                ),
                                textAlign: TextAlign.end,
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
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Phone",
                                style: GoogleFonts.montserrat(
                                  color: MColors.textGrey,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "+55 47 99874 6735",
                                style: GoogleFonts.montserrat(
                                    color: MColors.primaryPurple,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
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
                      child: RawMaterialButton(
                        onPressed: () {},
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Gender",
                                style: GoogleFonts.montserrat(
                                  color: MColors.textGrey,
                                  fontSize: 13.0,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Non-binary",
                                style: GoogleFonts.montserrat(
                                    color: MColors.primaryPurple,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.end,
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
            ),
          ),
        ],
      ),
    );
  }
}
