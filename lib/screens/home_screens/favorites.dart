import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';

class FavoritesScreen extends StatefulWidget {
  final favoritesScreen;
  FavoritesScreen(this.favoritesScreen);
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                "assets/images/noFavs.svg",
                height: 150,
              ),
            ),
            Container(
              child: Text(
                "No Favorites",
                style: GoogleFonts.montserrat(
                  color: MColors.textDark,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 30.0,
                left: 30.0,
                top: 10.0,
              ),
              child: Text(
                "Stores, Petsitters and veterinary clinics that you mark as favorites will show up here.",
                style: GoogleFonts.montserrat(
                  color: MColors.textGrey,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
