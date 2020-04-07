import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/screens/home_screens/favorites.dart';
import 'package:mollet/screens/home_screens/history.dart';
import 'package:mollet/screens/home_screens/home.dart';
import 'package:mollet/screens/home_screens/inbox.dart';
import 'package:mollet/screens/home_screens/settings.dart';
import 'package:mollet/utils/colors.dart';

class TabsLayout extends StatefulWidget {
  @override
  _TabsLayoutState createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout> {
  final PageStorageBucket bucket = PageStorageBucket();

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  final List<Widget> _children = [
    HomeScreen(
      key: PageStorageKey("homeKey"),
    ),
    HistoryScreen(
      key: PageStorageKey("historyKey"),
    ),
    FavoritesScreen(
      key: PageStorageKey("favoritesKey"),
    ),
    InboxScreen(
      key: PageStorageKey("inboxKey"),
    ),
    SettingsScreen(
      key: PageStorageKey("settingsKey"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        title: buildAppBarTitle(),
      ),
      body: PageStorage(
        child: _children[_currentIndex],
        bucket: bucket,
      ),
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
          onTap: onTabTapped,
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  //Build Appbar Titles

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

  // Building Tab Item Icons

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
}
