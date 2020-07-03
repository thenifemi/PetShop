import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/screens/tab_screens/cart1.dart';
import 'package:mollet/screens/tab_screens/history.dart';
import 'package:mollet/screens/tab_screens/home.dart';
import 'package:mollet/screens/tab_screens/notifications.dart';
import 'package:mollet/screens/tab_screens/settings.dart';
import 'package:mollet/utils/colors.dart';
import 'package:provider/provider.dart';
import 'allWidgets.dart';

class TabsLayout extends StatefulWidget {
  @override
  _TabsLayoutState createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout> {
  final PageStorageBucket bucket = PageStorageBucket();

  int _currentIndex = 0;

  @override
  void initState() {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    getCart(cartNotifier);
    super.initState();
  }

  final List<Widget> _children = [
    HomeScreen(
      key: PageStorageKey("homeKey"),
    ),
    Cart1(
      key: PageStorageKey("cart1"),
    ),
    HistoryScreen(
      key: PageStorageKey("historyKey"),
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
    "assets/images/icons/Home.svg",
    "assets/images/icons/Bag.svg",
    "assets/images/icons/Chart.svg",
    "assets/images/icons/Notification.svg",
    "assets/images/icons/Setting.svg",
  ];

  final _appBarTitle = [
    "Pet Shop",
    "Bag",
    "History",
    "Notifications",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        title: Row(
          children: <Widget>[
            _currentIndex == 0
                ? Container(
                    height: 24.0,
                    child: Image.asset(
                      "assets/images/footprint.png",
                    ),
                  )
                : Container(),
            SizedBox(width: 5.0),
            Text(
              _appBarTitle
                  .map((title) {
                    return title;
                  })
                  .where(
                      (title) => _appBarTitle.indexOf(title) == _currentIndex)
                  .toString()
                  .replaceAll("\)", "")
                  .replaceAll("\(", ""),
              style: boldFont(
                  _currentIndex == 0 ? MColors.primaryPurple : MColors.textGrey,
                  22.0),
            ),
          ],
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
            final bool isCartSelected = _tabIcons.indexOf(e) == 1;
            return BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        e,
                        height: 22,
                        color: isSelected
                            ? MColors.primaryPurple
                            : MColors.textGrey,
                      ),
                    ),
                    isCartSelected && cartList.isNotEmpty
                        ? Positioned(
                            right: 0,
                            child: new Container(
                              padding: EdgeInsets.all(1),
                              decoration: new BoxDecoration(
                                color: Colors.redAccent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 7,
                                minHeight: 7,
                              ),
                            ),
                          )
                        : Positioned(
                            right: 0,
                            child: new Container(
                              padding: EdgeInsets.all(1),
                              decoration: new BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 7,
                                minHeight: 7,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              title: Text(
                "",
              ),
              backgroundColor: MColors.primaryPurple,
            );
          }).toList(),
        ),
      ),
    );
  }
}
