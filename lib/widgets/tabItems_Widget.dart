import 'package:mollet/model/data/Products.dart';

allProducts(prods) {
  Iterable<ProdProducts> all = prods;
  return all;
}

dogProducts(prods) {
  Iterable<ProdProducts> dog = prods.where((e) => e.pet == "dog");
  return dog;
}

catProducts(prods) {
  Iterable<ProdProducts> cat = prods.where((e) => e.pet == "cat");
  return cat;
}

fishProducts(prods) {
  Iterable<ProdProducts> fish = prods.where((e) => e.pet == "fish");
  return fish;
}

birdProducts(prods) {
  Iterable<ProdProducts> bird = prods.where((e) => e.pet == "bird");
  return bird;
}

reptileProducts(prods) {
  Iterable<ProdProducts> reptile = prods.where((e) => e.pet == "reptile");
  return reptile;
}

smallpetProducts(prods) {
  Iterable<ProdProducts> smallpet = prods.where((e) => e.pet == "smallpet");
  return smallpet;
}
