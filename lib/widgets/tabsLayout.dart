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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final _tabIcons = [
    "assets/images/home.svg",
    "assets/images/clock.svg",
    "assets/images/cart.svg",
    "assets/images/mail.svg",
    "assets/images/settings.svg",
  ];

  final _appBarTitle = [
    "Home",
    "History",
    "Cart",
    "Inbox",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        title: Text(
          _appBarTitle
              .map((title) {
                return title;
              })
              .where((title) => _appBarTitle.indexOf(title) == _currentIndex)
              .toString()
              .replaceAll("\)", "")
              .replaceAll("\(", ""),
          style: GoogleFonts.montserrat(
              color: MColors.textGrey,
              fontSize: 30.0,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: PageStorage(
        child: _children[_currentIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          elevation: 0.0,
          selectedFontSize: 12.0,
          selectedItemColor: MColors.primaryPurple,
          unselectedItemColor: MColors.textGrey,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: MColors.primaryWhite,
          onTap: onTabTapped,
          items: _tabIcons.map((e) {
            final bool isSelected = _tabIcons.indexOf(e) == _currentIndex;
            return BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.only(top: 15.0),
                child: SvgPicture.asset(
                  e,
                  height: 20,
                  color: isSelected ? MColors.primaryPurple : MColors.textGrey,
                ),
              ),
              title: Text(""),
              backgroundColor: MColors.primaryPurple,
            );
          }).toList(),
        ),
      ),
    );
  }
}
