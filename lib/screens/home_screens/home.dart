import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/widgets/provider.dart';

class HomeScreen extends StatefulWidget {
  // final homeScreen;
  HomeScreen({this.onPush});
  final ValueChanged<int> onPush;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream<QuerySnapshot> getUsersNameStreamSnapshot(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('usersName')
        .snapshots()
        .asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Hi ",
                          style: GoogleFonts.montserrat(
                              fontSize: 22.0,
                              color: MColors.primaryPurple,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        child: StreamBuilder(
                            stream: getUsersNameStreamSnapshot(context),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text(
                                  "Human",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 22.0,
                                    color: MColors.primaryPurple,
                                  ),
                                  textAlign: TextAlign.start,
                                );
                              } else {
                                return Text(
                                  snapshot.data.documents[0]['name'],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 22.0,
                                    color: MColors.primaryPurple,
                                  ),
                                  textAlign: TextAlign.start,
                                  // ),
                                );
                              }
                            }),
                      ),
                      Container(
                        child: Text(
                          ",",
                          style: GoogleFonts.montserrat(
                              fontSize: 22.0,
                              color: MColors.textDark,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                  child: TextFormField(
                    // onSaved: (val) => _email = val,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: "Search product or service here...",
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        color: MColors.textGrey,
                      ),
                      contentPadding:
                          new EdgeInsets.symmetric(horizontal: 25.0),
                      fillColor: MColors.primaryWhite,
                      hasFloatingPlaceholder: false,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                      ),
                    ),
                    style: GoogleFonts.montserrat(
                        fontSize: 18.0, color: MColors.textDark),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        // color: MColors.primaryWhiteSmoke,
        padding: const EdgeInsets.only(
          // right: 30,
          left: 20.0,
          top: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 300,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Popular",
                                style: GoogleFonts.montserrat(
                                  fontSize: 30.0,
                                  color: MColors.textDark,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {},
                              child: Text(
                                "SEE ALL",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: MColors.textGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, i) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: RawMaterialButton(
                                  onPressed: () {
                                    // Navigator.of(context).pushNamed('/PetShop');
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 0.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(20.0),
                                      height: 250.0,
                                      width: 200.0,
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
                              SizedBox(width: 20.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                height: 100.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 50,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Shop by pet",
                          style: GoogleFonts.montserrat(
                            fontSize: 18.0,
                            color: MColors.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, i) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RawMaterialButton(
                                onPressed: () {
                                  // Navigator.of(context).pushNamed('/PetShop');
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    height: 50.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      color: MColors.dashPurple,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Dogs",
                                        style: GoogleFonts.montserrat(
                                            fontSize: 16.0,
                                            color: MColors.textGrey,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 180.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Services",
                                style: GoogleFonts.montserrat(
                                  fontSize: 26.0,
                                  color: MColors.textDark,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {},
                              child: Text(
                                "SEE ALL",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: MColors.textGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, i) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(10.0),
                                ),
                                child: RawMaterialButton(
                                  onPressed: () {
                                    // Navigator.of(context).pushNamed('/PetShop');
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 0.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(20.0),
                                      height: 150.0,
                                      width: 250.0,
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
                                              "assets/images/dogs.svg",
                                              //Icons made by "https://www.flaticon.com/authors/photo3idea-studio"
                                              height: 40,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "Grooming",
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
                              SizedBox(width: 20.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 120.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 120,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Top Rated",
                                style: GoogleFonts.montserrat(
                                  fontSize: 26.0,
                                  color: MColors.textDark,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {},
                              child: Text(
                                "SEE MORE",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: MColors.textGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, i) => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RawMaterialButton(
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
                                    height: 800.0,
                                    width: 280.0,
                                    decoration: BoxDecoration(
                                      color: MColors.dashPurple,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Linda Martin",
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
                              SizedBox(width: 20.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // child: SingleChildScrollView(
      //   child: Container(
      //     color: MColors.primaryWhiteSmoke,
      //     child: Padding(
      //       padding: const EdgeInsets.all(30.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: <Widget>[

      //           Container(
      //             color: MColors.primaryWhiteSmoke,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.start,
      //               children: <Widget>[
      //                 RawMaterialButton(
      //                   onPressed: () {
      //                     Navigator.of(context).pushNamed('/PetShop');
      //                   },
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: new BorderRadius.circular(10.0),
      //                   ),
      //                   child: Padding(
      //                     padding: const EdgeInsets.only(bottom: 0.0),
      //                     child: Container(
      //                       padding: const EdgeInsets.all(20.0),
      //                       height: 165.0,
      //                       decoration: BoxDecoration(
      //                         color: MColors.dashBlue,
      //                         borderRadius: BorderRadius.all(
      //                           Radius.circular(10.0),
      //                         ),
      //                       ),
      //                       child: Row(
      //                         children: <Widget>[
      //                           Container(
      //                             padding: const EdgeInsets.all(20.0),
      //                             child: SvgPicture.asset(
      //                               "assets/images/petfood.svg",
      //                               //Icons made by "https://www.flaticon.com/authors/photo3idea-studio"
      //                               height: 80,
      //                             ),
      //                           ),
      //                           Expanded(
      //                             child: Text(
      //                               "Shop trusted stores for Pet supplies",
      //                               style: GoogleFonts.montserrat(
      //                                   fontSize: 22.0,
      //                                   color: MColors.textGrey,
      //                                   fontWeight: FontWeight.bold),
      //                               textAlign: TextAlign.start,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 30.0,
      //                 ),
      //                 RawMaterialButton(
      //                   onPressed: () {},
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: new BorderRadius.circular(10.0),
      //                   ),
      //                   child: Padding(
      //                     padding: const EdgeInsets.only(),
      //                     child: Container(
      //                       padding: const EdgeInsets.all(20.0),
      //                       height: 165.0,
      //                       decoration: BoxDecoration(
      //                         color: MColors.dashPurple,
      //                         borderRadius: BorderRadius.all(
      //                           Radius.circular(10.0),
      //                         ),
      //                       ),
      //                       child: Row(
      //                         children: <Widget>[
      //                           Container(
      //                             padding: const EdgeInsets.all(20.0),
      //                             child: SvgPicture.asset(
      //                               "assets/images/veterinarian.svg",
      //                               height: 80,
      //                             ),
      //                           ),
      //                           Expanded(
      //                             child: Text(
      //                               "Book a Vet appointment",
      //                               style: GoogleFonts.montserrat(
      //                                   fontSize: 22.0,
      //                                   color: MColors.textGrey,
      //                                   fontWeight: FontWeight.bold),
      //                               textAlign: TextAlign.start,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 SizedBox(
      //                   height: 30.0,
      //                 ),
      //                 RawMaterialButton(
      //                   onPressed: () {},
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: new BorderRadius.circular(10.0),
      //                   ),
      //                   child: Padding(
      //                     padding: const EdgeInsets.only(),
      //                     child: Container(
      //                       padding: const EdgeInsets.all(20.0),
      //                       height: 165.0,
      //                       decoration: BoxDecoration(
      //                         color: MColors.dashAmber,
      //                         borderRadius: BorderRadius.all(
      //                           Radius.circular(10.0),
      //                         ),
      //                       ),
      //                       child: Row(
      //                         children: <Widget>[
      //                           Container(
      //                             padding: const EdgeInsets.all(20.0),
      //                             child: SvgPicture.asset(
      //                               "assets/images/petsitter.svg",
      //                               height: 80,
      //                             ),
      //                           ),
      //                           Expanded(
      //                             child: Text(
      //                               "Hire professional Pet services",
      //                               style: GoogleFonts.montserrat(
      //                                   fontSize: 22.0,
      //                                   color: MColors.textGrey,
      //                                   fontWeight: FontWeight.bold),
      //                               textAlign: TextAlign.start,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     // bottomNavigationBar: MBottomNavBar(MBottomNavBar),
      //   ),
      // ),
    );
  }
}
