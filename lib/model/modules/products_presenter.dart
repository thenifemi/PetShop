import 'package:mollet/model/data/products_data.dart';
import 'package:mollet/dependency_injection.dart';

abstract class ProductsListViewContract {
  void onLoadPetsComplete(List<Products> items);
  void onLoadPetsError();
}

class ProductsListPresenter {
  ProductsListViewContract _view;
  ProductsRepo _repository;

  ProductsListPresenter(this._view) {
    _repository = Injector().productsRepo;
  }

  void loadPets() {
    _repository
        .fetchPets()
        .then((c) => _view.onLoadPetsComplete(c))
        .catchError((onError) => _view.onLoadPetsError());
  }
}
