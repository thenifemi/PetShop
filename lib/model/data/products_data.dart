import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Products {
  String productImage;
  String pet;

  Products({
    this.productImage,
    this.pet,
  });

  Products.fromMap(Map<String, dynamic> map)
      : pet = map["pet"],
        productImage = map["productImage"];
}

abstract class ProductsRepo {
  Future<List<Products>> fetchPets();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) {
      return "Exception";
    }
    return "Exception $_message";
  }
}
