class OrdersList {
  String orderID;
  String orderTime;
  String orderDate;
  String orderStatus;
  String shippingAddress;
  List<dynamic> order;

  OrdersList.fromMap(Map<String, dynamic> data) {
    orderID = data["orderID"];
    orderTime = data["orderTime"];
    orderDate = data["orderDate"];
    orderStatus = data["orderStatus"];
    shippingAddress = data["shippingAddress"];
    order = data["order"];
  }
  Map<String, dynamic> toMap() {
    return {
      'orderID': orderID,
      'orderTime': orderTime,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'shippingAddress': shippingAddress,
      'order': order.map((i) => i.toMap()).toList(),
    };
  }
}
