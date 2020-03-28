import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Security",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(children: <Widget>[
          SizedBox(
            height: 60,
            width: double.infinity,
            child: RawMaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/ChangePassword');
              },
              child: Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: SvgPicture.asset(
                      "assets/images/key.svg",
                      height: 20,
                      color: MColors.textGrey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "Change password",
                      style: GoogleFonts.montserrat(
                        color: MColors.primaryPurple,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: MColors.textGrey,
                    size: 16.0,
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1.0,
          ),
        ]),
      ),
    );
  }
}
