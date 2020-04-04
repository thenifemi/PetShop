import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/screens/home_screens/favorites.dart';
import 'package:mollet/screens/home_screens/history.dart';
import 'package:mollet/screens/home_screens/home.dart';
import 'package:mollet/screens/home_screens/inbox.dart';
import 'package:mollet/screens/home_screens/settings.dart';
import 'package:mollet/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class MBottomNavBar extends StatefulWidget {
  final mBottomNavBar;
  MBottomNavBar(this.mBottomNavBar);

  @override
  _MBottomNavBarState createState() => _MBottomNavBarState();
}

class _MBottomNavBarState extends State<MBottomNavBar> {
  int _currentIndex = 0;

  HomeScreen homeScreen;
  HistoryScreen historyScreen;
  FavoritesScreen favoritesScreen;
  InboxScreen inboxScreen;
  SettingsScreen settingsScreen;
  List<Widget> tabs;
  Widget currentTab;

  @override
  void initState() {
    homeScreen = HomeScreen();
    historyScreen = HistoryScreen();
    favoritesScreen = FavoritesScreen();
    inboxScreen = InboxScreen();
    settingsScreen = SettingsScreen();

    tabs = [
      homeScreen,
      historyScreen,
      favoritesScreen,
      inboxScreen,
      settingsScreen
    ];

    currentTab = homeScreen;

    super.initState();
  }

  Widget buildHomeIcon() {
    if (_currentIndex == 0) {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/home.svg",
          height: 20,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/home.svg",
          height: 18,
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
          height: 20,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/clock.svg",
          height: 18,
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
          height: 20,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/fav.svg",
          height: 18,
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
          height: 20,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/mail.svg",
          height: 18,
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
          height: 20,
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.only(top: 15.0),
        child: SvgPicture.asset(
          "assets/images/settings.svg",
          height: 18,
          color: MColors.textGrey,
        ),
      );
    }
  }

  Widget buildAppBarTitle() {
    if (_currentIndex == 0) {
      return Text(
        "Home",
        style: GoogleFonts.montserrat(
            color: MColors.textGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_currentIndex == 1) {
      return Text(
        "History",
        style: GoogleFonts.montserrat(
            color: MColors.textGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_currentIndex == 2) {
      return Text(
        "Favorites",
        style: GoogleFonts.montserrat(
            color: MColors.textGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_currentIndex == 3) {
      return Text(
        "Inbox",
        style: GoogleFonts.montserrat(
            color: MColors.textGrey,
            fontSize: 30.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_currentIndex == 4) {
      return Text(
        "Settings",
        style: GoogleFonts.montserrat(
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
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        title: buildAppBarTitle(),
      ),
      body: currentTab,
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
              currentTab = tabs[index];
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
