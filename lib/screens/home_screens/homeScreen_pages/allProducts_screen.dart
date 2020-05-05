import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';

class AllProductsScreen extends StatefulWidget {
  AllProductsScreen({Key key}) : super(key: key);

  @override
  _AllProductsScreenState createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: _tabItems.length, vsync: this);
    super.initState();
  }

  final _tabItems = [
    "All",
    "Dogs",
    "Cats",
    "Fish",
    "Birds",
    "Reptiles",
    "Small Pets",
  ];

  final _tabViewItems = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.orange,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: MColors.primaryWhiteSmoke,
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
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // _submit();
            },
            child: SvgPicture.asset(
              "assets/images/cart.svg",
              height: 25.0,
            ),
          )
        ],
      ),
      body: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: MColors.primaryWhiteSmoke,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            child: Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20.0, left: 20.0, bottom: 5.0),
                    child: Container(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          labelText: "Search product here...",
                          labelStyle: GoogleFonts.montserrat(
                            fontSize: 14.0,
                            color: MColors.textGrey,
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 25.0),
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
                  ),
                  TabBar(
                    unselectedLabelColor: MColors.textGrey,
                    unselectedLabelStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 14.0,
                    ),
                    labelColor: MColors.primaryPurple,
                    isScrollable: true,
                    indicatorColor: MColors.primaryPurple,
                    tabs: _tabItems.map((e) {
                      return Tab(
                        child: Text(
                          e,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      );
                    }).toList(),
                    controller: _tabController,
                  )
                ],
              ),
            ),
            preferredSize: const Size.fromHeight(50),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabViewItems.map((e) {
            return Container(
              color: e,
            );
          }).toList(),
        ),
      ),
    );
  }
}
