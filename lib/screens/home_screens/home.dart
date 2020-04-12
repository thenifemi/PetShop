import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/MOCK_productsData.dart';
import 'package:mollet/model/data/products_data.dart';
import 'package:mollet/model/modules/products_presenter.dart';
import 'package:mollet/screens/home_screens/homeScreen_buttonPages/homeProductScreens/productDetailsScreen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/widgets/provider.dart';
import 'package:mollet/widgets/starRatings.dart';

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
  bool _isLoading;

  _HomeScreenState(this._products) {
    _presenter = ProductsListPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _isLoading = true;

    _presenter.loadProducts();
    _presenter.loadPets();
    _presenter.loadCategories();
    _presenter.loadServices();
  }

  Stream<QuerySnapshot> getUsersNameStreamSnapshot(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('usersName')
        .snapshots()
        .asBroadcastStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
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
        color: MColors.primaryWhiteSmoke,
        padding: const EdgeInsets.only(
          left: 20.0,
          top: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 280.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 280,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Popular",
                                style: GoogleFonts.montserrat(
                                  fontSize: 30.0,
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
                      _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Expanded(
                              child: _products == null
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _products.length,
                                      itemBuilder: (context, i) {
                                        final Products product = _products[i];

                                        return _popularBlockWidget(product, i);
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
                height: 150.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150,
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
                            fontWeight: FontWeight.w500,
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
                                          child: CircularProgressIndicator(),
                                        )
                                      : _shopByPetBlock(pet);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 50,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          "Categories",
                          style: GoogleFonts.montserrat(
                            fontSize: 22.0,
                            color: MColors.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                        child: _categories == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _categories.length,
                                itemBuilder: (context, i) {
                                  final Products category = _categories[i];

                                  return _isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : _categoriesBlock(category);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 250.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 250,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Services",
                                style: GoogleFonts.montserrat(
                                  fontSize: 26.0,
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
                      Expanded(
                        child: _services == null
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: _services.length,
                                itemBuilder: (context, i) {
                                  final Products service = _services[i];

                                  return _isLoading
                                      ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                      : _servicesBlock(service);
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 150.0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 150,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Featured brands",
                                style: GoogleFonts.montserrat(
                                  fontSize: 24.0,
                                  color: MColors.textDark,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            RawMaterialButton(
                              onPressed: () {},
                              child: Text(
                                "SEE MORE",
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
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 8,
                          itemBuilder: (context, i) => Row(
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
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 0.0),
                                  child: Container(
                                    padding: const EdgeInsets.all(20.0),
                                    height: 100.0,
                                    width: 280.0,
                                    decoration: BoxDecoration(
                                      color: MColors.dashPurple,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Text(
                                            "Linda Martin",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 16.0,
                                                color: MColors.textGrey,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _popularBlockWidget(Products product, i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(15.0),
          ),
          child: RawMaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetails(_products[i]),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                height: 200.0,
                width: 300.0,
                decoration: BoxDecoration(
                  color: MColors.primaryWhite,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
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
                            product.name,
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
                            "\$${product.price.toString()}",
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
                          child: product.productImage,
                          tag: product.productID.toString(),
                        ),
                        height: 160,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15.0),
      ],
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              height: 150.0,
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
                      child: pet.productImage,
                      height: 120,
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
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  Widget _categoriesBlock(Products category) {
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
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              height: 80.0,
              width: 150.0,
              decoration: BoxDecoration(
                color: MColors.primaryWhiteSmoke,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: Center(
                child: Text(
                  category.category,
                  style: GoogleFonts.montserrat(
                      fontSize: 26.0,
                      color: MColors.textGrey,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.0),
      ],
    );
  }

  Widget _servicesBlock(Products service) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
          child: RawMaterialButton(
            onPressed: () {
              // Navigator.of(context).pushNamed('/PetShop');
            },
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Container(
                padding: const EdgeInsets.all(0.0),
                height: 200.0,
                width: 250.0,
                decoration: BoxDecoration(
                  color: MColors.primaryWhite,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      child: service.productImage,
                      height: 150.0,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Center(
                        child: Text(
                          service.service,
                          style: GoogleFonts.montserrat(
                              fontSize: 20.0,
                              color: MColors.textGrey,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 20.0),
      ],
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
}
