import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class ImageCapture extends StatefulWidget {
  @override
  _ImageCaptureState createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
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

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
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
    );
  }

  Widget imageEdit() {
    return Container(
      child: ListView(
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
    );
  }
}

class Uploader extends StatefulWidget {
  final File file;
  Uploader(this.file);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://molletapp.appspot.com');

  StorageUploadTask _uploadTask;

  void _startUpload() async {
    final uEmail = await AuthService().getCurrentEmail();

    String filePath = 'userImages/$uEmail.png';
    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: primaryButtonPurple(Icon(Icons.cloud_upload), () {
        progressIndicator(MColors.primaryPurple);
        _startUpload();
      }),
    );
  }
}
