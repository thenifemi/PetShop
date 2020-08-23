import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class EditImage extends StatefulWidget {
  final File imageFile;
  EditImage({
    this.imageFile,
    Key key,
  }) : super(key: key);

  @override
  _EditImageState createState() => _EditImageState(imageFile);
}

class _EditImageState extends State<EditImage> {
  final File imageFile;
  _EditImageState(
    this.imageFile,
  );
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
          "Edit Photo",
          style: boldFont(MColors.primaryPurple, 16.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        null,
      ),
      body: primaryContainer(Container(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              child: Image.file(imageFile),
            ),
            SizedBox(height: 20.0),
            Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(left: 15.0),
                    height: 30.0,
                    width: double.infinity,
                    child: Text(
                      "Crop photo",
                      style: normalFont(MColors.textDark, 14.0),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(left: 15.0),
                    height: 30.0,
                    width: double.infinity,
                    child: Text(
                      "Save photo",
                      style: normalFont(MColors.primaryPurple, 14.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
