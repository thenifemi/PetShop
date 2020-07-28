import 'package:flutter/material.dart';
import 'package:mollet/model/notifiers/orders_notifier.dart';
import 'package:mollet/utils/colors.dart';

import 'package:mollet/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  Future ordersFuture;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    OrdersNotifier ordersNotifier = Provider.of<OrdersNotifier>(context);
    var orderList = ordersNotifier.orderList;
    return Scaffold(
      key: _scaffoldKey,
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
                  : null;
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
}
