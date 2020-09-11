import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petShop/model/data/Products.dart';
import 'package:petShop/model/data/bannerAds.dart';
import 'package:petShop/model/data/brands.dart';
import 'package:petShop/model/data/cart.dart';
import 'package:petShop/model/data/orders.dart';
import 'package:petShop/model/notifiers/bannerAd_notifier.dart';
import 'package:petShop/model/notifiers/brands_notifier.dart';
import 'package:petShop/model/notifiers/cart_notifier.dart';
import 'package:petShop/model/notifiers/orders_notifier.dart';
import 'package:petShop/model/notifiers/products_notifier.dart';
import 'package:petShop/model/services/auth_service.dart';

final db = FirebaseFirestore.instance;

//Getting products
getProdProducts(ProductsNotifier productsNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("food").get();

  List<ProdProducts> _prodProductsList = [];

  snapshot.docs.forEach((document) {
    ProdProducts prodProducts = ProdProducts.fromMap(document.data());

    _prodProductsList.add(prodProducts);
  });

  productsNotifier.productsList = _prodProductsList;
}

//Adding users' product to cart
addProductToCart(product) async {
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userCart")
      .doc(uEmail)
      .collection("cartItems")
      .doc(product.productID)
      .set(product.toMap())
      .catchError((e) {
    print(e);
  });
}

//Getting brands
getBrands(BrandsNotifier brandsNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("brands").get();

  List<Brands> _brandsList = [];

  snapshot.docs.forEach((document) {
    Brands brands = Brands.fromMap(document.data());
    _brandsList.add(brands);
  });

  brandsNotifier.brandsList = _brandsList;
}

//Getting bannersAds
getBannerAds(BannerAdNotifier bannerAdNotifier) async {
  QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("bannerAds").get();

  List<BannerAds> _bannerAdsList = [];

  snapshot.docs.forEach((document) {
    BannerAds bannerAds = BannerAds.fromMap(document.data());
    _bannerAdsList.add(bannerAds);
  });

  bannerAdNotifier.bannerAdsList = _bannerAdsList;
}

//Getting users' cart
getCart(CartNotifier cartNotifier) async {
  final uEmail = await AuthService().getCurrentEmail();

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("userCart")
      .doc(uEmail)
      .collection("cartItems")
      .get();

  List<Cart> _cartList = [];

  snapshot.docs.forEach((document) {
    Cart cart = Cart.fromMap(document.data());
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
      db.collection("userCart").doc(uEmail).collection("cartItems");

  await cartRef.doc(cartItem.productID).update(
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
      db.collection("userCart").doc(uEmail).collection("cartItems");

  await cartRef.doc(cartItem.productID).update(
    {'quantity': cartItem.quantity, 'totalPrice': cartItem.totalPrice},
  );
}

//Removing item from cart
removeItemFromCart(cartItem) async {
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userCart")
      .doc(uEmail)
      .collection("cartItems")
      .doc(cartItem.productID)
      .delete();
}

//Clearing users' cart
clearCartAfterPurchase() async {
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection('userCart')
      .doc(uEmail)
      .collection("cartItems")
      .get()
      .then((snapshot) {
    for (DocumentSnapshot doc in snapshot.docs) {
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
      .doc(uEmail)
      .collection("orders")
      .doc(orderID)
      .set(
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
      .doc(uEmail)
      .collection("orders")
      .doc(orderID)
      .set(
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

  QuerySnapshot ordersSnapshot =
      await db.collection("userOrder").doc(uEmail).collection("orders").get();

  List<OrdersList> _ordersListList = [];

  ordersSnapshot.docs.forEach((document) {
    OrdersList ordersList = OrdersList.fromMap(document.data());
    _ordersListList.add(ordersList);
  });
  orderListNotifier.orderListList = _ordersListList;
}
