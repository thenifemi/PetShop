import 'package:mollet/model/data/products_data.dart';
import 'package:mollet/dependency_injection.dart';

abstract class ProductsListViewContract {
  void onLoadProductsComplete(List<Products> items);
  void onLoadProductsError();

  void onLoadPetsComplete(List<Products> items);
  void onLoadPetsError();

  void onLoadCategoriesComplete(List<Products> items);
  void onLoadCategoriesError();

  void onLoadServicesComplete(List<Products> items);
  void onLoadServicesError();
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

  void loadPets() {
    _repository
        .fetchPets()
        .then((c) => _view.onLoadPetsComplete(c))
        .catchError((onError) => _view.onLoadPetsError());
  }

  void loadCategories() {
    _repository
        .fetchCategories()
        .then((c) => _view.onLoadCategoriesComplete(c))
        .catchError((onError) => _view.onLoadCategoriesError());
  }

  void loadServices() {
    _repository
        .fetchServices()
        .then((c) => _view.onLoadServicesComplete(c))
        .catchError((onError) => _view.onLoadServicesError());
  }
}
