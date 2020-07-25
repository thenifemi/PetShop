import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/screens/tab_screens/history.dart';
import 'package:mollet/screens/tab_screens/home.dart';
import 'package:mollet/screens/tab_screens/homeScreen_pages/bag.dart';
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
      key: PageStorageKey("pageKey"),
    ),
    HistoryScreen(
      key: PageStorageKey("pageKey"),
    ),
    InboxScreen(
      key: PageStorageKey("pageKey"),
    ),
    SettingsScreen(
      key: PageStorageKey("pageKey"),
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final _tabIcons = [
    "assets/images/icons/Home.svg",
    "assets/images/icons/Chart.svg",
    "assets/images/icons/Notification.svg",
    "assets/images/icons/Setting.svg",
  ];

  final _appBarTitle = [
    "Pet Shop",
    "History",
    "Notifications",
    "Settings",
  ];

  // final _tabIconsTitle = [
  //   "Home",
  //   "History",
  //   "Notifications",
  //   "Settings",
  // ];

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;

    return Scaffold(
      appBar: primaryAppBar(
        null,
        _currentIndex != 0
            ? Text(
                _appBarTitle
                    .map((title) {
                      return title;
                    })
                    .where(
                        (title) => _appBarTitle.indexOf(title) == _currentIndex)
                    .toString()
                    .replaceAll("\)", "")
                    .replaceAll("\(", ""),
                style: boldFont(MColors.textGrey, 20.0),
              )
            : Row(
                children: <Widget>[
                  Expanded(
                    child: primaryTextField(
                      null,
                      null,
                      "Search for products",
                      null,
                      true,
                      null,
                      false,
                      false,
                      true,
                      TextInputType.text,
                      null,
                      SvgPicture.asset(
                        "assets/images/icons/Search.svg",
                        color: MColors.textGrey,
                        height: 16.0,
                      ),
                      0.0,
                    ),
                  ),
                  Container(
                    width: 50,
                    child: RawMaterialButton(
                      onPressed: () async {
                        CartNotifier cartNotifier =
                            Provider.of<CartNotifier>(context, listen: false);
                        var navigationResult = await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Bag(),
                          ),
                        );
                        if (navigationResult == true) {
                          setState(() {
                            getCart(cartNotifier);
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: SvgPicture.asset(
                                "assets/images/icons/Bag.svg",
                                height: 25,
                                color: MColors.textGrey,
                              ),
                            ),
                            cartList.isNotEmpty
                                ? Positioned(
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
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
                                    child: Container(
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
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
                    ),
                  ),
                ],
              ),
        MColors.primaryWhiteSmoke,
        null,
        false,
        null,
      ),
      body: PageStorage(
        child: _children[_currentIndex],
        bucket: bucket,
      ),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          elevation: 0.0,
          selectedItemColor: MColors.primaryPurple,
          unselectedItemColor: MColors.textGrey,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: MColors.primaryWhite,
          onTap: onTabTapped,
          items: _tabIcons.map((e) {
            final bool isSelected = _tabIcons.indexOf(e) == _currentIndex;
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
                  ],
                ),
              ),
              title: Text("", style: normalFont(null, 0.0)),
              backgroundColor: MColors.primaryPurple,
            );
          }).toList(),
        ),
      ),
    );
  }
}
