        
import 'package:mollet/model/data/products_data.dart';
import 'package:mollet/model/data/MOCK_productsData.dart';
import 'package:mollet/model/data/PROD_productsData.dart';

enum Flavor { MOCK, PROD }

//DI
class Injector {
  static final Injector _singleton = Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }
  Injector._internal();

  ProductsRepo get productsRepo {
    switch (_flavor) {
      case Flavor.MOCK: return MockProductsRepo();
        
        break;
      default: return ProdProductsRepo();
    }
  }
}