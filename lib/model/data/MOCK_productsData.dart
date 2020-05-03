import 'package:flutter/cupertino.dart';

import 'products_data.dart';

class MockProductsRepo implements ProductsRepo {
  @override
  Future<List<Products>> fetchPets() {
    return Future.value(pets);
  }
}

var pets = <Products>[
  Products(
    productImage: 'assets/images/productImages/dogs.png',
    pet: "Dogs",
  ),
  Products(
    productImage: 'assets/images/productImages/cat.png',
    pet: "Cats",
  ),
  Products(
    productImage: 'assets/images/productImages/fish.png',
    pet: "Fish",
  ),
  Products(
    productImage: 'assets/images/productImages/bird.png',
    pet: "Birds",
  ),
  Products(
    productImage: 'assets/images/productImages/reptile.png',
    pet: "Reptiles",
  ),
  Products(
    productImage: 'assets/images/productImages/hedgehog.png',
    pet: "Small pets",
  ),
];
