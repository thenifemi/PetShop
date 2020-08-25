import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/utils/cardUtils/cardStrings.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/internetConnectivity.dart';
import 'package:mollet/utils/textFieldFormaters.dart';
import 'package:mollet/widgets/allWidgets.dart';

import '../../main.dart';

class EditProfile extends StatefulWidget {
  final UserDataProfile user;
  EditProfile(this.user);

  @override
  _EditProfileState createState() => _EditProfileState(user);
}

class _EditProfileState extends State<EditProfile> {
  File _imageFile;

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
                      child: Container(
                        child:
                            user.profilePhoto == null || user.profilePhoto == ""
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(9.0),
                                    child: Image.asset(
                                      "assets/images/petshop-footprint-logo-whiteBg.png",
                                      height: 90.0,
                                      width: 90.0,
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(9.0),
                                    child: FadeInImage.assetNetwork(
                                      image: user.profilePhoto,
                                      fit: BoxFit.fill,
                                      height: 90.0,
                                      width: 90.0,
                                      placeholder:
                                          "assets/images/petshop-footprint-logo-whiteBg.png",
                                    ),
                                  ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: MColors.dashPurple,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () => imageCapture(),
                  child: Text(
                    "Edit photo",
                    style: boldFont(MColors.primaryPurple, 14.0),
                  ),
                ),
                SizedBox(height: 30.0),
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

  //select imge via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    // ignore: deprecated_member_use
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  //cropper plugin
  Future<void> _cropImage(_imageFileForCrop) async {
    File _cropped = await ImageCropper.cropImage(
      sourcePath: _imageFileForCrop.path,
      androidUiSettings: AndroidUiSettings(
        toolbarColor: MColors.primaryPurple,
        toolbarWidgetColor: MColors.primaryWhiteSmoke,
        toolbarTitle: "Crop image",
      ),
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9,
      ],
    );
    // ignore: unnecessary_statements
    _cropped == null ? null : saveImage(_cropped);
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  // image capture

  imageCapture() {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Container(
        margin: EdgeInsets.only(
          bottom: 10.0,
          left: 10.0,
          right: 10.0,
          top: 5.0,
        ),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: MColors.primaryWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        height: 150.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Change profile photo",
                style: boldFont(MColors.textDark, 18.0),
              ),
              SizedBox(height: 30.0),
              GestureDetector(
                onTap: () {
                  _pickImage(ImageSource.camera)
                      .then((v) => _cropImage(_imageFile));
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 15.0),
                  height: 30.0,
                  width: double.infinity,
                  child: Text(
                    "Capture with camera",
                    style: normalFont(MColors.textDark, 14.0),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  _pickImage(ImageSource.gallery)
                      .then((v) => _cropImage(_imageFile));
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(left: 15.0),
                  height: 30.0,
                  width: double.infinity,
                  child: Text(
                    "Choose from photo gallery",
                    style: normalFont(MColors.textDark, 14.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveImage(imageFile) {
    showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.8,
          decoration: BoxDecoration(
            color: MColors.primaryWhiteSmoke,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
            ),
          ),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              primaryAppBar(
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: MColors.textGrey,
                  ),
                  onPressed: () {
                    _clear();
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  "Save Photo",
                  style: boldFont(MColors.primaryPurple, 16.0),
                ),
                MColors.primaryWhiteSmoke,
                null,
                true,
                <Widget>[
                  FlatButton(
                    onPressed: () async {
                      await checkInternetConnectivity().then((value) {
                        value == true
                            ? () async {
                                _showLoadingDialog();
                                await updateProfilePhoto(imageFile)
                                    .then((value) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  Navigator.pop(context, true);
                                });
                              }()
                            : () {
                                showNoInternetSnack(_scaffoldKey);
                                Navigator.of(context).pushAndRemoveUntil(
                                  CupertinoPageRoute(
                                    builder: (_) => MyApp(),
                                  ),
                                  (Route<dynamic> route) => false,
                                );
                              }();
                      });
                    },
                    child: Text(
                      "Save",
                      style: boldFont(MColors.primaryPurple, 14.0),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.0),
              primaryContainer(
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height / 2.3,
                        child: Image.file(imageFile),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future _showLoadingDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return;
          },
          child: AlertDialog(
            backgroundColor: MColors.primaryWhiteSmoke,
            content: Container(
              height: 20.0,
              child: Row(
                children: <Widget>[
                  Text(
                    "Saving...",
                    style: normalFont(MColors.textGrey, 14.0),
                  ),
                  Spacer(),
                  progressIndicator(MColors.primaryPurple),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
