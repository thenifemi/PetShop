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
    OrdersNotifier ordersNotifier =
        Provider.of<OrdersNotifier>(context, listen: false);
    ordersFuture = getOrders(ordersNotifier);
    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OrdersNotifier ordersNotifier = Provider.of<OrdersNotifier>(context);
    var orderList = ordersNotifier.orderList;
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
      child: Center(
        child: Text(
          "ORDERS",
          style: boldFont(MColors.primaryPurple, 30.0),
        ),
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
