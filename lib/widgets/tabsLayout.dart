import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/notifiers/notifications_notifier.dart';
import 'package:mollet/model/notifiers/orders_notifier.dart';
import 'package:mollet/model/notifiers/products_notifier.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/services/pushNotification_service.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/screens/tab_screens/history.dart';
import 'package:mollet/screens/tab_screens/home.dart';
import 'package:mollet/screens/tab_screens/homeScreen_pages/bag.dart';
import 'package:mollet/screens/tab_screens/notifications.dart';
import 'package:mollet/screens/tab_screens/search_screens/search_screen.dart';
import 'package:mollet/screens/tab_screens/settings.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/internetConnectivity.dart';
import 'package:provider/provider.dart';
import 'allWidgets.dart';

class TabsLayout extends StatefulWidget {
  @override
  _TabsLayoutState createState() => _TabsLayoutState();
}

class _TabsLayoutState extends State<TabsLayout> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final PageStorageBucket bucket = PageStorageBucket();

  int _currentIndex = 0;

  @override
  void initState() {
    checkInternetConnectivity().then((value) => {
          value == true
              ? () {
                  // BrandsNotifier brandsNotifier =
                  //     Provider.of<BrandsNotifier>(context, listen: false);
                  // getBrands(brandsNotifier);

                  ProductsNotifier productsNotifier =
                      Provider.of<ProductsNotifier>(context, listen: false);
                  getProdProducts(productsNotifier);

                  UserDataProfileNotifier profileNotifier =
                      Provider.of<UserDataProfileNotifier>(context,
                          listen: false);
                  getProfile(profileNotifier);

                  UserDataAddressNotifier addressNotifier =
                      Provider.of<UserDataAddressNotifier>(context,
                          listen: false);
                  getAddress(addressNotifier);

                  CartNotifier cartNotifier =
                      Provider.of<CartNotifier>(context, listen: false);
                  getCart(cartNotifier);

                  OrderListNotifier orderListNotifier =
                      Provider.of<OrderListNotifier>(context, listen: false);
                  getOrders(orderListNotifier);

                  NotificationsNotifier notificationsNotifier =
                      Provider.of<NotificationsNotifier>(context,
                          listen: false);
                  getNotifications(notificationsNotifier);

                  saveDeviceToken();
                }()
              : showNoInternetSnack(_scaffoldKey)
        });

    super.initState();
  }

  final List<Widget> _children = [
    HomeScreen(
      key: PageStorageKey("pageKey1"),
    ),
    HistoryScreen(
      key: PageStorageKey("pageKey2"),
    ),
    InboxScreen(
      key: PageStorageKey("pageKey3"),
    ),
    SettingsScreen(
      key: PageStorageKey("pageKey4"),
    ),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final _tabIcons = [
    "assets/images/icons/Home.svg",
    "assets/images/icons/Bookmark.svg",
    "assets/images/icons/Notification.svg",
    "assets/images/icons/Setting.svg",
  ];

  final _appBarTitle = [
    "Pet Shop",
    "Orders",
    "Notifications",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;

    return Scaffold(
      key: _scaffoldKey,
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => Search(),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        height: 40.0,
                        decoration: BoxDecoration(
                            color: MColors.primaryWhite,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            )),
                        child: Row(
                          children: [
                            Text(
                              "Search for products...",
                              style: normalFont(MColors.textGrey, 14.0),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                              "assets/images/icons/Search.svg",
                              color: MColors.textGrey,
                              height: 20.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 50,
                    child: RawMaterialButton(
                      onPressed: () async {
                        CartNotifier cartNotifier =
                            Provider.of<CartNotifier>(context, listen: false);
                        var navigationResult = await Navigator.of(context).push(
                          CupertinoPageRoute(
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
                            Positioned(
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  color: cartList.isNotEmpty
                                      ? Colors.redAccent
                                      : Colors.transparent,
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
        color: MColors.primaryWhite,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
