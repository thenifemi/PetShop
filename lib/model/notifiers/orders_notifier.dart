import 'package:flutter/foundation.dart';
import 'package:mollet/model/data/orders.dart';

class OrderstNotifier with ChangeNotifier {
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
