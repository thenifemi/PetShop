import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/dependency_injection.dart';
import 'package:mollet/model/data/MOCK_productsData.dart';
import 'package:mollet/model/data/carousel_data.dart';
import 'package:mollet/model/data/products_data.dart';
import 'package:mollet/model/modules/products_presenter.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/prodModel/Product_service.dart';
import 'package:mollet/prodModel/Products.dart';
import 'package:mollet/prodModel/products_notifier.dart';
import 'package:mollet/screens/home_screens/homeScreen_buttonPages/homeProductScreens/productDetailsScreen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/provider.dart';
import 'package:mollet/widgets/starRatings.dart';
import 'package:provider/provider.dart';

import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState(products);
}

class _HomeScreenState extends State<HomeScreen>
    implements ProductsListViewContract {
  ProductsListPresenter _presenter;
  List<Products> _products;
  List<Products> _pets;
  List<Products> _categories;
  List<Products> _services;
  List<Products> _brands;
  Flavor _flavor;
  bool _isLoading;

  _HomeScreenState(this._products) {
    _presenter = ProductsListPresenter(this);
  }

  @override
  void initState() {
    ProductsNotifier productsNotifier =
        Provider.of<ProductsNotifier>(context, listen: false);

    getProdProducts(productsNotifier);

    _isLoading = true;
    _presenter.loadProducts();
    _presenter.loadPets();
    _presenter.loadCategories();
    _presenter.loadServices();
    super.initState();
  }

  Stream<QuerySnapshot> getUsersNameStreamSnapshot(
      BuildContext context) async* {
    final uid = await MyProvider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('usersName')
        .snapshots()
        .asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);
    var prods = productsNotifier.productsList;
    var prodDetails = productsNotifier.currentProdProduct;

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 5.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Hi ",
                          style: GoogleFonts.montserrat(
                              fontSize: 22.0,
                              color: MColors.primaryPurple,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        child: StreamBuilder(
                            stream: getUsersNameStreamSnapshot(context),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Text(
                                  "Human",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 22.0,
                                    color: MColors.primaryPurple,
                                  ),
                                  textAlign: TextAlign.start,
                                );
                              } else {
                                return Text(
                                  snapshot.data.documents[0]['name'],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 22.0,
                                    color: MColors.primaryPurple,
                                  ),
                                  textAlign: TextAlign.start,
                                  // ),
                                );
                              }
                            }),
                      ),
                      Container(
                        child: Text(
                          ",",
                          style: GoogleFonts.montserrat(
                              fontSize: 22.0,
                              color: MColors.textDark,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                  child: TextFormField(
                    // onSaved: (val) => _email = val,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      labelText: "Search product or service here...",
                      labelStyle: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        color: MColors.textGrey,
                      ),
                      contentPadding:
                          new EdgeInsets.symmetric(horizontal: 25.0),
                      fillColor: MColors.primaryWhite,
                      hasFloatingPlaceholder: false,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 0.0,
                        ),
                      ),
                    ),
                    style: GoogleFonts.montserrat(
                        fontSize: 18.0, color: MColors.textDark),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.only(
          left: 20.0,
          top: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Provider<Products>(
                create: (BuildContext context) => Products(),
                child: Consumer<Products>(builder: (context, p, child) {
                  return Container(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: (MediaQuery.of(context).size.height) / 7,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              "Shop by pet",
                              style: GoogleFonts.montserrat(
                                fontSize: 18.0,
                                color: MColors.textDark,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Expanded(
                            child: _pets == null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: _pets.length,
                                    itemBuilder: (context, i) {
                                      final Products pet = _pets[i];

                                      return _isLoading
                                          ? Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : _shopByPetBlock(pet);
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 240,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Popular",
                                style: GoogleFonts.montserrat(
                                  fontSize: 20.0,
                                  color: MColors.textDark,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {},
                              child: Text(
                                "SEE ALL",
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  color: MColors.textGrey,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                      ),
                      prods.isEmpty
                          ? Center(
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Expanded(
                              child: prods == null
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 8,
                                      itemBuilder: (context, i) {
                                        // final Products product = _products[i];
                                        var prod = prods[i];

                                        return _popularBlockWidget(
                                            prod, i, prodDetails, prods);
                                      },
                                    ),
                            ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: _buildCarouselBlock(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _shopByPetBlock(Products pet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            // Navigator.of(context).pushNamed('/PetShop');
          },
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            width: 100.0,
            decoration: BoxDecoration(
              color: MColors.primaryWhiteSmoke,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: _flavor == Flavor.MOCK
                        ? Image.network(pet.productImage)
                        : Image.asset(pet.productImage),
                    // child: pet.productImage,
                    // height: 120,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    pet.pet,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.0,
                      color: MColors.textGrey,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  Widget _popularBlockWidget(prod, i, prodDetails, prods) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            prodDetails = prod;

            print(prodDetails.name);

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetails(prodDetails, prods),
              ),
            );
          },
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            width: 280,
            decoration: BoxDecoration(
              color: MColors.primaryWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.03),
                    offset: Offset(0, 10),
                    blurRadius: 10,
                    spreadRadius: 0),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      width: 150.0,
                      child: Text(
                        prod.name,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            fontSize: 16.0,
                            color: MColors.textDark,
                            fontWeight: FontWeight.w500),
                        textAlign: TextAlign.left,
                        softWrap: true,
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        "\$${prod.price}",
                        style: GoogleFonts.montserrat(
                            fontSize: 28.0,
                            color: MColors.primaryPurple,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: IconTheme(
                        data: IconThemeData(
                          color: Colors.amber,
                          size: 18,
                        ),
                        child: StarDisplay(value: 4),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Hero(
                      // child: _flavor == Flavor.MOCK
                      //     ? Image.network(prod.productImage)
                      //     : Image.asset(product.productImage),
                      child: Image.network(
                        prod.productImage,
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height,
                      ),
                      tag: prod.productID,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 15.0),
      ],
    );
  }

  Widget _buildCarouselBlock() {
    return CarouselSlider(
      options:
          CarouselOptions(height: (MediaQuery.of(context).size.height) / 4.7),
      items: [0, 1, 2, 3, 4].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Consumer<CarouselData>(
              builder: (context, carousel, child) => Container(
                decoration: BoxDecoration(
                  color: MColors.primaryWhite,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.03),
                        offset: Offset(0, 10),
                        blurRadius: 10,
                        spreadRadius: 0),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    carousel.carouselImages[i],
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  @override
  void onLoadProductsComplete(List<Products> items) {
    setState(() {
      _products = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadProductsError() {
    // TODO: implement onLoadProductsError
  }

  @override
  void onLoadPetsComplete(List<Products> items) {
    _pets = items;
    _isLoading = false;
  }

  @override
  void onLoadPetsError() {
    // TODO: implement onLoadPetsError
  }

  @override
  void onLoadCategoriesComplete(List<Products> items) {
    _categories = items;
    _isLoading = false;
  }

  @override
  void onLoadCategoriesError() {
    // TODO: implement onLoadCategoriesError
  }

  @override
  void onLoadServicesComplete(List<Products> items) {
    _services = items;
    _isLoading = false;
  }

  @override
  void onLoadServicesError() {
    // TODO: implement onLoadServicesError
  }

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }
}
