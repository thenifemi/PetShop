import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/screens/home_screens/home.dart';
import 'package:mollet/screens/home_screens/settings.dart';
import 'package:mollet/utils/colors.dart';

class MBottomNavBar extends StatefulWidget {
  final mBottomNavBar;
  MBottomNavBar(this.mBottomNavBar);

  @override
  _MBottomNavBarState createState() => _MBottomNavBarState();
}

class _MBottomNavBarState extends State<MBottomNavBar> {
  int _currentIndex = 0;

  final tabs = [
    HomeScreen(HomeScreen),
    Center(child: Text("A")),
    Center(child: Text("B")),
    Center(child: Text("c")),
    SettingsScreen(SettingsScreen),
  ];

  Widget buildHomeIcon() {
    if (_currentIndex == 0) {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/home.svg",
          height: 25,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/home.svg",
          height: 23,
          color: MColors.textGrey,
        ),
      );
    }
  }

  Widget buildHistoryIcon() {
    if (_currentIndex == 1) {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/clock.svg",
          height: 25,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/clock.svg",
          height: 23,
          color: MColors.textGrey,
        ),
      );
    }
  }

  Widget buildFavoritesIcon() {
    if (_currentIndex == 2) {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/fav.svg",
          height: 25,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/fav.svg",
          height: 23,
          color: MColors.textGrey,
        ),
      );
    }
  }

  Widget buildInboxIcon() {
    if (_currentIndex == 3) {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/mail.svg",
          height: 25,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/mail.svg",
          height: 23,
          color: MColors.textGrey,
        ),
      );
    }
  }

  Widget buildSettingsIcon() {
    if (_currentIndex == 4) {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/settings.svg",
          height: 25,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/settings.svg",
          height: 23,
          color: MColors.textGrey,
        ),
      );
    }
  }

  Widget buildAppBarTitle() {
    if (_currentIndex == 0) {
      return Text(
        "Home",
        style: TextStyle(
            color: MColors.textGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_currentIndex == 1) {
      return Text(
        "History",
        style: TextStyle(
            color: MColors.textGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_currentIndex == 2) {
      return Text(
        "Favorites",
        style: TextStyle(
            color: MColors.textGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_currentIndex == 3) {
      return Text(
        "Inbox",
        style: TextStyle(
            color: MColors.textGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_currentIndex == 4) {
      return Text(
        "Settings",
        style: TextStyle(
            color: MColors.textGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        title: buildAppBarTitle(),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        height: 65.0,
        child: BottomNavigationBar(
          elevation: 0.0,
          selectedFontSize: 12.0,
          selectedItemColor: MColors.primaryPurple,
          unselectedItemColor: MColors.textGrey,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: MColors.primaryWhite,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: buildHomeIcon(),
              title: Text(""),
              backgroundColor: MColors.primaryPurple,
            ),
            BottomNavigationBarItem(
              icon: buildHistoryIcon(),
              title: Text(""),
              backgroundColor: MColors.primaryPurple,
            ),
            BottomNavigationBarItem(
              icon: buildFavoritesIcon(),
              title: Text(""),
              backgroundColor: MColors.primaryPurple,
            ),
            BottomNavigationBarItem(
              icon: buildInboxIcon(),
              title: Text(""),
              backgroundColor: MColors.primaryPurple,
            ),
            BottomNavigationBarItem(
              icon: buildSettingsIcon(),
              title: Text(""),
              backgroundColor: MColors.primaryPurple,
            ),
          ],
        ),
      ),
    );
  }
}
