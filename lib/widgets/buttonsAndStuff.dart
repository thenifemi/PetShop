import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';

Widget primaryButtonPurple(
  String value,
  Widget buttonChild,
) {
  return SizedBox(
    width: double.infinity,
    child: RawMaterialButton(
      elevation: 0.0,
      hoverElevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      fillColor: MColors.primaryPurple,
      onPressed: null,
      child: buttonChild,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
    ),
  );
}

Widget progressIndicator() {
  return Container(
    child: Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
      ),
    ),
  );
}
