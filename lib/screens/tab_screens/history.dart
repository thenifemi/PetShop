import 'package:flutter/material.dart';
import 'package:mollet/model/notifiers/orders_notifier.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/utils/colors.dart';

import 'package:mollet/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  Future ordersFuture;
  TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _tabItems = [
    "Current orders",
    "Past orders",
  ];

  @override
  void initState() {
    OrderListNotifier orderListNotifier =
        Provider.of<OrderListNotifier>(context, listen: false);
    ordersFuture = getOrders(orderListNotifier);
    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrderListNotifier orderListNotifier =
        Provider.of<OrderListNotifier>(context);
    var orderList = orderListNotifier.orderListList;

    return Scaffold(
      body: FutureBuilder(
        future: ordersFuture,
        builder: (c, s) {
          switch (s.connectionState) {
            case ConnectionState.active:
              return progressIndicator(MColors.primaryPurple);
              break;
            case ConnectionState.done:
              return orderList.isEmpty
                  ? emptyScreen(
                      "assets/images/noHistory.svg",
                      "No Orders",
                      "Your past orders, transactions and hires will show up here.",
                    )
                  : ordersScreen(orderList);
              break;
            case ConnectionState.waiting:
              return progressIndicator(MColors.primaryPurple);
              break;
            default:
              return progressIndicator(MColors.primaryPurple);
          }
        },
      ),
    );
  }

  Widget ordersScreen(orderList) {
    final _tabBody = [
      currentOrder(orderList),
      pastOrder(),
    ];
    return Scaffold(
      key: _scaffoldKey,
      appBar: primaryAppBar(
        null,
        TabBar(
          unselectedLabelColor: MColors.textGrey,
          unselectedLabelStyle: normalFont(MColors.textGrey, 16.0),
          labelColor: MColors.primaryPurple,
          labelStyle: boldFont(MColors.primaryPurple, 20.0),
          indicatorWeight: 0.01,
          isScrollable: true,
          tabs: _tabItems.map((e) {
            return Tab(
              child: Text(
                e,
              ),
            );
          }).toList(),
          controller: _tabController,
        ),
        MColors.primaryWhiteSmoke,
        null,
        false,
        null,
      ),
      body: primaryContainer(
        TabBarView(
          children: _tabBody,
          controller: _tabController,
        ),
      ),
    );
  }

  Widget currentOrder(orderList) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: orderList.length,
        itemBuilder: (context, i) {
          OrderListNotifier orderListNotifier =
              Provider.of<OrderListNotifier>(context);
          var _orderList = orderListNotifier.orderListList;

          var orderListItem = _orderList[i];
          var orderID = orderListItem.orderID.substring(
            orderListItem.orderID.length - 11,
          );

          var order = _orderList[i].order.toList();
          var orderTotalPriceList = order.map((e) => e['totalPrice']);
          var orderTotalPrice = orderTotalPriceList
              .reduce((sum, element) => sum + element)
              .toStringAsFixed(2);

          return Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
              color: MColors.primaryWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Order No. ",
                              style: normalFont(MColors.textGrey, 14.0),
                            ),
                            Text(
                              orderID,
                              style: boldFont(MColors.textGrey, 14.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        orderListItem.orderDate,
                        style: normalFont(MColors.textGrey, 14.0),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  height: 70.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: order.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        height: 50.0,
                        width: 40.0,
                        child: FadeInImage.assetNetwork(
                          image: order[i]['productImage'],
                          fit: BoxFit.fill,
                          placeholder: "assets/images/placeholder.jpg",
                          placeholderScale:
                              MediaQuery.of(context).size.height / 2,
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        order.length.toString() + " Items",
                        style: normalFont(MColors.textGrey, 14.0),
                      ),
                      Spacer(),
                      Text(
                        "\$" + orderTotalPrice.toString(),
                        style: boldFont(MColors.textGrey, 14.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Container(
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Details",
                        style: boldFont(MColors.primaryPurple, 14.0),
                      ),
                      Spacer(),
                      Text(
                        i == 1 ? "En route" : "Processing",
                        style: i == 1
                            ? boldFont(Colors.green, 14.0)
                            : boldFont(Colors.amber, 14.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget pastOrder() {
    return emptyScreen(
      "assets/images/noHistory.svg",
      "No past orders",
      "Orders that have been delivered to you will show up here.",
    );
  }
}
