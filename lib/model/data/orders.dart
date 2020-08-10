import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersList {
  String orderID;
  Timestamp orderDate;
  String orderStatus;
  String shippingAddress;
  List<dynamic> order;

  OrdersList.fromMap(Map<String, dynamic> data) {
    orderID = data["orderID"];
    orderDate = data["orderDate"];
    orderStatus = data["orderStatus"];
    shippingAddress = data["shippingAddress"];
    order = data["order"];
  }
  Map<String, dynamic> toMap() {
    return {
      'orderID': orderID,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'shippingAddress': shippingAddress,
      'order': order.map((i) => i.toMap()).toList(),
    };
  }
}
