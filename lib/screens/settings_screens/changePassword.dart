import 'package:flutter/material.dart';
import 'package:mollet/utils/cardUtils/cardStrings.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String password;
  bool _autoValidate = false;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          "Change password",
          style: boldFont(MColors.primaryPurple, 18.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text(
              "Save",
              style: boldFont(MColors.primaryPurple, 16.0),
            ),
          )
        ],
      ),
      body: primaryContainer(
        SingleChildScrollView(
          child: Form(
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Current password",
                          style: normalFont(MColors.textGrey, null),
                        ),
                        SizedBox(height: 5.0),
                        primaryTextField(
                          null,
                          null,
                          "",
                          (val) => password = val,
                          true,
                          (String value) =>
                              value.isEmpty ? Strings.fieldReq : null,
                          true,
                          _autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          SizedBox(
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
                          0.50,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "New password",
                          style: normalFont(MColors.textGrey, null),
                        ),
                        SizedBox(height: 5.0),
                        primaryTextField(
                          null,
                          null,
                          "",
                          (val) => password = val,
                          true,
                          (String value) =>
                              value.isEmpty ? Strings.fieldReq : null,
                          true,
                          _autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          SizedBox(
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
                          0.50,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Confirm new password",
                          style: normalFont(MColors.textGrey, null),
                        ),
                        SizedBox(height: 5.0),
                        primaryTextField(
                          null,
                          null,
                          "",
                          (val) => password = val,
                          true,
                          (String value) =>
                              value.isEmpty ? Strings.fieldReq : null,
                          true,
                          _autoValidate,
                          false,
                          TextInputType.text,
                          null,
                          SizedBox(
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
                          0.50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
