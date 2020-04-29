import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mollet/prodModel/Products.dart';
import 'package:mollet/prodModel/products_notifier.dart';

import 'products_data.dart';

class ProdProductsRepo extends ChangeNotifier implements ProductsRepo {
  

  @override
  Future<List<Products>> fetchProducts() async {
    return null;
  }

  @override
  Future<List<Products>> fetchPets() {
    // TODO: implement fetchPets
    return null;
  }

  @override
  Future<List<Products>> fetchCategories() {
    // TODO: implement fetchCategories
    return null;
  }

  @override
  Future<List<Products>> fetchServices() {
    // TODO: implement fetchServices
    return null;
  }

  @override
  notifyListeners() {
    // TODO: implement notifyListeners
    return null;
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
}
