import 'package:flutter/material.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/provider.dart';

class SettingsScreen extends StatefulWidget {
  final mSettings;
  SettingsScreen(this.mSettings);
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  void _showLogOutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sign Out"),
            content: Text("Are you sure sure you want to log out?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: MColors.textGrey),
                ),
              ),
              RaisedButton(
                onPressed: () async {
                  try {
                    AuthService auth = Provider.of(context).auth;
                    auth.signOut();
                    Navigator.of(context).pushReplacementNamed("/Login");
                    print("Signed out.");
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Sign out"),
                color: MColors.primaryPurple,
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
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
                  _showLogOutDialog();
                },
                child: Text(
                  "Logout",
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
    );
  }
}
