import 'package:flutter/foundation.dart';
import 'package:mollet/model/data/orders.dart';

class OrdersNotifier with ChangeNotifier {
  List<Orders> _ordersList = [];
  Orders _orders;

  List<Orders> get orderList => _ordersList;
  Orders get orders => _orders;

  set orderList(List<Orders> ordersList) {
    _ordersList = ordersList;
    notifyListeners();
  }

  set orders(Orders orders) {
    _orders = orders;
    notifyListeners();
  }
}

class OrderListNotifier with ChangeNotifier {
  List<OrdersList> _ordersListList = [];

  List<OrdersList> get orderListList => _ordersListList;

  set orderListList(List<OrdersList> ordersListList) {
    _ordersListList = ordersListList;
    notifyListeners();
  }
}
