import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/data/brands.dart';
import 'package:mollet/model/data/cart.dart';
import 'package:mollet/model/data/orders.dart';
import 'package:mollet/model/notifiers/brands_notifier.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/notifiers/orders_notifier.dart';
import 'package:mollet/model/notifiers/products_notifier.dart';
import 'package:mollet/model/services/auth_service.dart';

final db = Firestore.instance;

//Getting products
getProdProducts(ProductsNotifier productsNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection("food").getDocuments();

  List<ProdProducts> _prodProductsList = [];

  snapshot.documents.forEach((document) {
    ProdProducts prodProducts = ProdProducts.fromMap(document.data);

    _prodProductsList.add(prodProducts);
  });

  productsNotifier.productsList = _prodProductsList;
}

//Adding users' product to cart
addProductToCart(product) async {
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userCart")
      .document(uEmail)
      .collection("cartItems")
      .document(product.productID)
      .setData(product.toMap())
      .catchError((e) {
    print(e);
  });
}

//Getting brands
getBrands(BrandsNotifier brandsNotifier) async {
  QuerySnapshot snapshot =
      await Firestore.instance.collection("brands").getDocuments();

  List<Brands> _brandsList = [];

  snapshot.documents.forEach((document) {
    Brands brands = Brands.fromMap(document.data);
    _brandsList.add(brands);
  });

  brandsNotifier.brandsList = _brandsList;
}

//Getting users' cart
getCart(CartNotifier cartNotifier) async {
  final uEmail = await AuthService().getCurrentEmail();

  QuerySnapshot snapshot = await Firestore.instance
      .collection("userCart")
      .document(uEmail)
      .collection("cartItems")
      .getDocuments();

  List<Cart> _cartList = [];

  snapshot.documents.forEach((document) {
    Cart cart = Cart.fromMap(document.data);
    _cartList.add(cart);
  });

  cartNotifier.cartList = _cartList;
}

//Adding item quantity, Price and updating data in cart
addAndApdateData(cartItem) async {
  final uEmail = await AuthService().getCurrentEmail();

  if (cartItem.quantity >= 9) {
    cartItem.quantity = cartItem.quantity = 9;
  } else {
    cartItem.quantity = cartItem.quantity + 1;
  }
  cartItem.totalPrice = cartItem.price * cartItem.quantity;

  CollectionReference cartRef =
      db.collection("userCart").document(uEmail).collection("cartItems");

  await cartRef.document(cartItem.productID).updateData(
    {'quantity': cartItem.quantity, 'totalPrice': cartItem.totalPrice},
  );
}

//Subtracting item quantity, Price and updating data in cart
subAndApdateData(cartItem) async {
  final uEmail = await AuthService().getCurrentEmail();

  if (cartItem.quantity <= 1) {
    cartItem.quantity = cartItem.quantity = 1;
  } else {
    cartItem.quantity = cartItem.quantity - 1;
  }
  cartItem.totalPrice = cartItem.price * cartItem.quantity;

  CollectionReference cartRef =
      db.collection("userCart").document(uEmail).collection("cartItems");

  await cartRef.document(cartItem.productID).updateData(
    {'quantity': cartItem.quantity, 'totalPrice': cartItem.totalPrice},
  );
}

//Removing item from cart
removeItemFromCart(cartItem) async {
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userCart")
      .document(uEmail)
      .collection("cartItems")
      .document(cartItem.productID)
      .delete();
}

//Clearing users' cart
clearCartAfterPurchase() async {
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection('userCart')
      .document(uEmail)
      .collection("cartItems")
      .getDocuments()
      .then((snapshot) {
    for (DocumentSnapshot doc in snapshot.documents) {
      doc.reference.delete();
    }
  });
}

//Adding users' product to cart
addCartToOrders(cartList, orderID, addressList) async {
  final uEmail = await AuthService().getCurrentEmail();
  var orderDate = FieldValue.serverTimestamp();

  var orderStatus = "processing";
  var shippingAddress = addressList.first.addressNumber +
      ", " +
      addressList.first.addressLocation;

  await db
      .collection("userOrder")
      .document(uEmail)
      .collection("orders")
      .document(orderID)
      .setData(
    {
      'orderID': orderID,
      'orderDate': orderDate,
      'orderStatus': orderStatus,
      'shippingAddress': shippingAddress,
      'order': cartList.map((i) => i.toMap()).toList(),
    },
  ).catchError((e) {
    print(e);
  });

  //Sending orders to merchant
  await db
      .collection("merchantOrder")
      .document(uEmail)
      .collection("orders")
      .document(orderID)
      .setData(
    {
      'orderID': orderID,
      'orderDate': orderDate,
      'shippingAddress': shippingAddress,
      'order': cartList.map((i) => i.toMap()).toList(),
    },
  ).catchError((e) {
    print(e);
  });
}

//Getting users' orders
getOrders(
  OrderListNotifier orderListNotifier,
) async {
  final uEmail = await AuthService().getCurrentEmail();

  QuerySnapshot ordersSnapshot = await db
      .collection("userOrder")
      .document(uEmail)
      .collection("orders")
      .getDocuments();

  List<OrdersList> _ordersListList = [];

  ordersSnapshot.documents.forEach((document) {
    OrdersList ordersList = OrdersList.fromMap(document.data);
    _ordersListList.add(ordersList);
  });
  orderListNotifier.orderListList = _ordersListList;
}
