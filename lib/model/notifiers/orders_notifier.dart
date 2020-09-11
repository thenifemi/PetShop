import 'package:flutter/foundation.dart';
import 'package:petShop/model/data/orders.dart';

class OrderListNotifier with ChangeNotifier {
  List<OrdersList> _ordersListList = [];

  List<OrdersList> get orderListList => _ordersListList;

  set orderListList(List<OrdersList> ordersListList) {
    _ordersListList = ordersListList;
    notifyListeners();
  }
}
