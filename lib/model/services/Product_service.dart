import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/data/brands.dart';
import 'package:mollet/model/data/cart.dart';
import 'package:mollet/model/notifiers/brands_notifier.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/notifiers/products_notifier.dart';
import 'package:mollet/model/services/auth_service.dart';

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
  final db = Firestore.instance;
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
  final db = Firestore.instance;
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
  final db = Firestore.instance;
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
  final db = Firestore.instance;
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
  final db = Firestore.instance;
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
addCartToOrders(cartItem, orderID) async {
  final db = Firestore.instance;
  final uEmail = await AuthService().getCurrentEmail();
  var orderDate = DateTime.now().day.toString() +
      "-" +
      DateTime.now().month.toString() +
      "-" +
      DateTime.now().year.toString();
  var orderTime = Timestamp.now().toDate().hour.toString() +
      ":" +
      Timestamp.now().toDate().minute.toString();

  await db
      .collection("userOrder")
      .document(uEmail)
      .collection("orders")
      .document(orderID)
      .collection("orderItems")
      .document(cartItem.productID)
      .setData(cartItem.toMap())
      .catchError((e) {
    print(e);
  });

  //Sending orders to merchant
  await db
      .collection("merchantOrder")
      .document(orderID)
      .collection("orders")
      .document(uEmail)
      .collection("orderItems")
      .document(cartItem.productID)
      .setData(cartItem.toMap())
      .catchError((e) {
    print(e);
  });

  //Adding Date and Time to order

  CollectionReference orderRef = db
      .collection("userOrder")
      .document(uEmail)
      .collection("orders")
      .document(orderID)
      .collection("orderItems");

  await orderRef.document(cartItem.productID).updateData(
    {
      'orderID': orderID,
      'orderTime': orderTime,
      'orderDate': orderDate,
    },
  );

  CollectionReference merchantOrderRef = db
      .collection("merchantOrder")
      .document(orderID)
      .collection("orders")
      .document(uEmail)
      .collection("orderItems");

  await merchantOrderRef.document(cartItem.productID).updateData(
    {
      'orderID': orderID,
      'orderTime': orderTime,
      'orderDate': orderDate,
    },
  );
}
