import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/MOCK_productsData.dart';
import 'package:mollet/model/data/products_data.dart';
import 'package:mollet/model/modules/products_presenter.dart';
import 'package:mollet/screens/home_screens/home.dart';
import 'package:mollet/utils/colors.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    implements ProductsListViewContract {
  List<Products> _products;
  ProductsListPresenter _presenter;
  int i;

  bool _isLoading;

  _ProductDetailsState() {
    _presenter = ProductsListPresenter(this);
  }

  @override
  void initState() {
    _isLoading = true;

    _presenter.loadProducts();
    print("HERE HERE");

    super.initState();
  }

  Widget _buildBody() {
    return Container(
      color: MColors.primaryWhite,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          _buildProductImage(),
          _buildProductDetails(),
        ],
      ),
    );
  }

  Widget _buildProductImage() {
    return Builder(
      builder: (context) {
        final Products product = _products[i];
        print(product.productID);

        return Container(
          height: (MediaQuery.of(context).size.height) / 2.5,
          color: MColors.primaryWhite,
          padding: const EdgeInsets.all(20.0),
          child: _products == null
              ? CircularProgressIndicator()
              : Image.asset('assets/images/productImages/buffalo.jpg'),
        );
      },
    );
  }

  Widget _buildProductDetails() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.green,
              height: 100,
            ),
            Container(
              color: Colors.pink,
              height: 100,
            ),
            Container(
              color: Colors.blue,
              height: 100,
            ),
            Container(
              color: Colors.yellow,
              height: 100,
            ),
            Container(
              color: Colors.black,
              height: 100,
            ),
            Container(
              color: Colors.green,
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: MColors.primaryWhiteSmoke,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textDark,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // title: Text(
        //   "Product name",
        //   style: GoogleFonts.montserrat(
        //       fontSize: 20.0,
        //       color: MColors.primaryPurple,
        //       fontWeight: FontWeight.bold),
        // ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: MColors.textDark,
            ),
            onPressed: () {
              // Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: Container(
        height: 60.0,
        child: RawMaterialButton(
          onPressed: () {},
          fillColor: MColors.primaryPurple,
          child: Text('Fixed Button'),
        ),
      ),
    );
  }

  @override
  void onLoadCategoriesComplete(List<Products> items) {}

  @override
  void onLoadCategoriesError() {
    // TODO: implement onLoadCategoriesError
  }

  @override
  void onLoadPetsComplete(List<Products> items) {
    // TODO: implement onLoadPetsComplete
  }

  @override
  void onLoadPetsError() {
    // TODO: implement onLoadPetsError
  }

  @override
  void onLoadProductsComplete(List<Products> items) {
    _products = items;
    _isLoading = false;
  }

  @override
  void onLoadProductsError() {
    // TODO: implement onLoadProductsError
  }

  @override
  void onLoadServicesComplete(List<Products> items) {
    // TODO: implement onLoadServicesComplete
  }

  @override
  void onLoadServicesError() {
    // TODO: implement onLoadServicesError
  }
}
