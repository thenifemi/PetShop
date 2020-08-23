import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mollet/credentials.dart';

import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class Uploader extends StatefulWidget {
  final File file;
  Uploader(this.file);

  @override
  _UploaderState createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  //Input the link to your own firebase storage bucket
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: FIREBASE_STORAGE_BUCKET);

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
