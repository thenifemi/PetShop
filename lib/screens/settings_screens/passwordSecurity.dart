import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petShop/screens/settings_screens/changePassword.dart';
import 'package:petShop/utils/colors.dart';
import 'package:petShop/utils/permission_handler.dart';
import 'package:petShop/widgets/allWidgets.dart';
import 'package:permission_handler/permission_handler.dart';

class SecurityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listTileIcons = [
      "assets/images/key.svg",
      "assets/images/icons/Location.svg",
    ];

    final listTileNames = [
      "Change password",
      "Location",
    ];

    final listTileActions = [
      () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (_) => ChangePasswordScreen(),
          ),
        );
      },
      () {
        PermissionUtil.isLocationServiceAndPermissionsActive().then((value) {
          if (value == false) {
            PermissionUtil.requestPermission(PermissionGroup.location);
          }
        });
      },
    ];

    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
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
          style: boldFont(MColors.primaryPurple, 16.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        null,
      ),
      body: primaryContainer(
        Container(
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: listTileNames.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return Container(
                child: Column(
                  children: <Widget>[
                    listTileButton(
                      listTileActions[i],
                      listTileIcons[i],
                      listTileNames[i],
                      MColors.primaryPurple,
                    ),
                    Divider(
                      height: 1.0,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
