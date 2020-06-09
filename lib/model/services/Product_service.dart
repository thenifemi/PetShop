import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mollet/model/data/brands.dart';
import 'package:mollet/model/data/cart.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/notifiers/brands_notifier.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/notifiers/products_notifier.dart';
import 'package:mollet/model/services/auth_service.dart';

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

getCart(CartNotifier cartNotifier) async {
  final uid = await AuthService().getCurrentUID();

  QuerySnapshot snapshot = await Firestore.instance
      .collection("userCart")
      .document(uid)
      .collection("cartItem")
      .getDocuments();

  List<Cart> _cartList = [];

  snapshot.documents.forEach((document) {
    Cart cart = Cart.fromMap(document.data);
    _cartList.add(cart);
  });

  cartNotifier.cartList = _cartList;
}

addProductToCart(product) async {
  final db = Firestore.instance;
  final uid = await AuthService().getCurrentUID();

  await db
      .collection("userCart")
      .document(uid)
      .collection("cartItem")
      .add(product.toMap())
      .catchError((e) {
    print(e);
  });
}

getAndUpdateQuantityStream() {
  final db = Firestore.instance;
  db.collection('food').snapshots();
}
