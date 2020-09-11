import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'package:petShop/model/data/Products.dart';

class ProductsNotifier with ChangeNotifier {
  List<ProdProducts> _prodProductsList = [];
  ProdProducts _currentProdProduct;

  UnmodifiableListView<ProdProducts> get productsList =>
      UnmodifiableListView(_prodProductsList);

  ProdProducts get currentProdProduct => _currentProdProduct;

  set productsList(List<ProdProducts> prodProductsList) {
    _prodProductsList = prodProductsList;
    notifyListeners();
  }

  set currentProdProduct(ProdProducts prodProducts) {
    _currentProdProduct = prodProducts;
    notifyListeners();
  }
}
