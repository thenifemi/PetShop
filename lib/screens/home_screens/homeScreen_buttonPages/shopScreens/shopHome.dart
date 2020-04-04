import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';

class ShopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: MColors.primaryWhite,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textDark,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Pet Shop",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: MColors.primaryWhiteSmoke,
        child: SingleChildScrollView(
          child: Container(
            color: MColors.primaryWhiteSmoke,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Container(
                      child: Text(
                        "Shop by Pet",
                        style: GoogleFonts.montserrat(
                          fontSize: 22.0,
                          color: MColors.textGrey,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    color: MColors.primaryWhiteSmoke,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed('/PetShop');
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    height: 165.0,
                                    width: 165.0,
                                    decoration: BoxDecoration(
                                      color: MColors.dashAmber,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SvgPicture.asset(
                                            "assets/images/dogs.svg",
                                            //Icons made by "https://www.flaticon.com/authors/photo3idea-studio"
                                            height: 95,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Dogs",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16.0,
                                                color: MColors.textGrey,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed('/PetShop');
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    height: 165.0,
                                    width: 165.0,
                                    decoration: BoxDecoration(
                                      color: MColors.dashPurple,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SvgPicture.asset(
                                            "assets/images/cats.svg",
                                            //Icons made by "https://www.flaticon.com/authors/photo3idea-studio"
                                            height: 95,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Cats",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16.0,
                                                color: MColors.textGrey,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed('/PetShop');
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    height: 165.0,
                                    width: 165.0,
                                    decoration: BoxDecoration(
                                      color: MColors.dashBlue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SvgPicture.asset(
                                            "assets/images/fish.svg",
                                            //Icons made by "https://www.flaticon.com/authors/photo3idea-studio"
                                            height: 95,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "fish",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16.0,
                                                color: MColors.textGrey,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed('/PetShop');
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    height: 165.0,
                                    width: 165.0,
                                    decoration: BoxDecoration(
                                      color: MColors.dashAmber,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SvgPicture.asset(
                                            "assets/images/birds.svg",
                                            //Icons made by "https://www.flaticon.com/authors/photo3idea-studio"
                                            height: 95,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Birds",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16.0,
                                                color: MColors.textGrey,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed('/PetShop');
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    height: 165.0,
                                    width: 165.0,
                                    decoration: BoxDecoration(
                                      color: MColors.dashPurple,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SvgPicture.asset(
                                            "assets/images/reptiles.svg",
                                            //Icons made by "https://www.flaticon.com/authors/photo3idea-studio"
                                            height: 95,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Reptiles",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16.0,
                                                color: MColors.textGrey,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 30.0,
                            ),
                            Expanded(
                              child: RawMaterialButton(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed('/PetShop');
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    height: 165.0,
                                    width: 165.0,
                                    decoration: BoxDecoration(
                                      color: MColors.dashBlue,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SvgPicture.asset(
                                            "assets/images/others.svg",
                                            //Icons made by "https://www.flaticon.com/authors/photo3idea-studio"
                                            height: 95,
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Others",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16.0,
                                                color: MColors.textGrey,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
