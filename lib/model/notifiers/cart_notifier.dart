import 'package:flutter/foundation.dart';
import 'package:petShop/model/data/cart.dart';

class CartNotifier with ChangeNotifier {
  List<Cart> _cartList = [];
  Cart _cart;

  List<Cart> get cartList => _cartList;
  Cart get cart => _cart;

  set cartList(List<Cart> cartList) {
    _cartList = cartList;
    notifyListeners();
  }

  set cart(Cart cart) {
    _cart = cart;
    notifyListeners();
  }
}
