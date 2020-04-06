import 'package:mollet/model/data/products_data.dart';
import 'package:mollet/dependency_injection.dart';

abstract class ProductsListViewContract {
  void onLoadProductsComplete(List<Products> items);
  void onLoadProductsError();
}

class ProductsListPresenter {
  ProductsListViewContract _view;
  ProductsRepo _repository;

  ProductsListPresenter(this._view) {
    _repository = Injector().productsRepo;
  }

  void loadProducts() {
    _repository
        .fetchProducts()
        .then((c) => _view.onLoadProductsComplete(c))
        .catchError((onError) => _view.onLoadProductsError());
  }
}
