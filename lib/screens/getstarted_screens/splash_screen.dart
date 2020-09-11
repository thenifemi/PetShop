import 'package:flutter/material.dart';
import 'package:petShop/utils/colors.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: MColors.primaryWhiteSmoke,
      child: Center(
        child: Container(
          height: 45.0,
          child:
              Image.asset("assets/images/petshop-footprint-logo-transBg.png"),
        ),
      ),
    );
  }
}
