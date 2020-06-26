import 'package:flutter/material.dart';
import 'package:mollet/utils/colors.dart';

Widget primaryButtonPurple(
  Widget buttonChild,
  void Function() onPressed,
) {
  return SizedBox(
    width: double.infinity,
    height: 60.0,
    child: RawMaterialButton(
      elevation: 0.0,
      hoverElevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      fillColor: MColors.primaryPurple,
      child: buttonChild,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
    ),
  );
}

Widget primaryButtonWhiteSmoke(
  Widget buttonChild,
  void Function() onPressed,
) {
  return SizedBox(
    width: double.infinity,
    height: 60.0,
    child: RawMaterialButton(
      elevation: 0.0,
      hoverElevation: 0.0,
      focusElevation: 0.0,
      highlightElevation: 0.0,
      fillColor: MColors.primaryWhiteSmoke,
      child: buttonChild,
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(10.0),
      ),
    ),
  );
}

Widget progressIndicator(Color color) {
  return Container(
    child: Center(
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        backgroundColor: color,
      ),
    ),
  );
}
