import 'package:flutter/material.dart';
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
              icon: Icon(Icons.home),
              title: Text("Home"),
              backgroundColor: MColors.primaryPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text("History"),
              backgroundColor: MColors.primaryPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text("Favorites"),
              backgroundColor: MColors.primaryPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline),
              title: Text("Inbox"),
              backgroundColor: MColors.primaryPurple,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text("Settings"),
              backgroundColor: MColors.primaryPurple,
            ),
          ],
        ),
      ),
    );
  }
}
