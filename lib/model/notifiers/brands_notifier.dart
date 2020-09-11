import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:petShop/model/data/brands.dart';

class BrandsNotifier with ChangeNotifier {
  List<Brands> _brandsList = [];
  Brands _brands;

  UnmodifiableListView<Brands> get brandsList =>
      UnmodifiableListView(_brandsList);

  Brands get brands => _brands;

  set brandsList(List<Brands> brandsList) {
    _brandsList = brandsList;
    notifyListeners();
  }

  set brands(Brands brands) {
    _brands = brands;
    notifyListeners();
  }
}
