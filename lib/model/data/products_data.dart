import 'dart:async';

import 'package:flutter/cupertino.dart';

class Products {
  Image productImage;
  String name;
  String brand;
  double price;
  String desc;
  String moreDesc;
  String foodType;
  String lifeStage;
  String flavor;
  String weight;
  String ingredients;
  String directions;
  String size;
  String productID;
  String pet;
  String category;
  String service;

  Products({
    this.productImage,
    this.name,
    this.brand,
    this.price,
    this.desc,
    this.moreDesc,
    this.foodType,
    this.lifeStage,
    this.flavor,
    this.weight,
    this.ingredients,
    this.directions,
    this.size,
    this.productID,
    this.pet,
    this.category,
    this.service,
  });

  Products.fromMap(Map<String, dynamic> map)
      : productImage = map["productImage"],
        name = map["name"],
        brand = map["brand"],
        price = map["price"],
        desc = map["desc"],
        moreDesc = map["moreDesc"],
        foodType = map["foodType"],
        lifeStage = map["lifeStage"],
        flavor = map["flavor"],
        weight = map["weight"],
        ingredients = map["ingredients"],
        directions = map["directions"],
        size = map["size"],
        productID = map["productID"],
        pet = map["pet"],
        category = map["category"],
        service = map["service"];
}

abstract class ProductsRepo {
  Future<List<Products>> fetchProducts();
  Future<List<Products>> fetchPets();
  Future<List<Products>> fetchCategories();
  Future<List<Products>> fetchServices();
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
