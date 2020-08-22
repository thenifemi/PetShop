import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/utils/cardUtils/cardStrings.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/textFieldFormaters.dart';
import 'package:mollet/widgets/allWidgets.dart';
import 'package:mollet/widgets/imageCapture_Widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
          "Profile",
          style: boldFont(MColors.primaryPurple, 16.0),
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
              style: boldFont(MColors.primaryPurple, 14.0),
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
                  height: 20.0,
                ),
                Center(
                  child: Hero(
                    tag: "profileAvatar",
                    child: GestureDetector(
                      onTap: () => imageCapture(),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: SvgPicture.asset(
                              "assets/images/femaleAvatar.svg",
                              height: 90,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: MColors.dashPurple,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: MColors.primaryPurple,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: MColors.primaryWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Full name",
                            style: normalFont(MColors.textGrey, null),
                          ),
                          SizedBox(height: 5.0),
                          primaryTextField(
                            null,
                            user.name,
                            "",
                            (val) => _name = val,
                            true,
                            (String value) =>
                                value.isEmpty ? Strings.fieldReq : null,
                            false,
                            _autoValidate,
                            false,
                            TextInputType.text,
                            null,
                            null,
                            0.50,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Email",
                            style: normalFont(MColors.textGrey, null),
                          ),
                          SizedBox(height: 5.0),
                          primaryTextField(
                            null,
                            user.email,
                            "",
                            null,
                            false,
                            null,
                            false,
                            _autoValidate,
                            false,
                            null,
                            null,
                            null,
                            0.50,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Phone",
                            style: normalFont(MColors.textGrey, null),
                          ),
                          SizedBox(height: 5.0),
                          primaryTextField(
                            null,
                            user.phone,
                            "",
                            (val) => _phone = val,
                            true,
                            (String value) =>
                                value.isEmpty ? Strings.fieldReq : null,
                            false,
                            _autoValidate,
                            true,
                            TextInputType.phone,
                            [maskTextInputFormatter],
                            null,
                            0.50,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

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

  // Profile Image---------------------------------------

  File _imageFile;

  //select imge via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  //cropper plugin
  Future<void> _cropImage() async {
    File _cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: MColors.primaryPurple,
          toolbarWidgetColor: MColors.primaryWhiteSmoke,
          toolbarTitle: "Crop image",
        ));
    setState(() {
      _imageFile = _cropped ?? _imageFile;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  // image capture

  imageCapture() {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.all(20.0),
        children: [
          SizedBox(
            height: 50.0,
            width: double.infinity,
            child: RawMaterialButton(
              onPressed: () =>
                  _pickImage(ImageSource.camera).then((v) => imageEdit()),
              child: Row(
                children: [
                  Icon(
                    Icons.camera,
                    size: 30.0,
                    color: MColors.primaryPurple,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Capture with camera",
                    style: normalFont(MColors.textGrey, 14.0),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          SizedBox(
            height: 50.0,
            width: double.infinity,
            child: RawMaterialButton(
              onPressed: () =>
                  _pickImage(ImageSource.gallery).then((v) => imageEdit()),
              child: Row(
                children: [
                  Icon(
                    Icons.photo_library,
                    color: MColors.primaryPurple,
                    size: 30.0,
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Select from photo gallery",
                    style: normalFont(MColors.textGrey, 14.0),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  imageEdit() {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: EdgeInsets.all(20.0),
        children: [
          ListView(
            children: [
              // ignore: sdk_version_ui_as_code
              if (_imageFile != null) ...[
                Image.file(_imageFile),
                Row(
                  children: [
                    FlatButton(
                      onPressed: _cropImage,
                      child: Icon(Icons.crop),
                    ),
                    FlatButton(
                      onPressed: _clear,
                      child: Icon(Icons.refresh),
                    ),
                  ],
                ),
                Uploader(_imageFile),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
