import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/screens/settings_screens/changePassword.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/permission_handler.dart';
import 'package:mollet/widgets/allWidgets.dart';
import 'package:permission_handler/permission_handler.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar(
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textGrey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Text(
          "Security",
          style: boldFont(MColors.primaryPurple, 18.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        null,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 60,
                width: double.infinity,
                child: RawMaterialButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ChangePasswordScreen(),
                      ),
                    );
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
          Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Column(children: <Widget>[
              SizedBox(
                height: 60,
                width: double.infinity,
                child: RawMaterialButton(
                  onPressed: () {
                    PermissionUtil.isLocationServiceAndPermissionsActive()
                        .then((value) {
                      if (value == false) {
                        PermissionUtil.requestPermission(
                            PermissionGroup.location);
                      }
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: SvgPicture.asset(
                          "assets/images/icons/Location.svg",
                          height: 20,
                          color: MColors.textGrey,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Location",
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
        ],
      ),
    );
  }
}
