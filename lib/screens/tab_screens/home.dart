import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/notifiers/products_notifier.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/screens/tab_screens/search_screens/search_tabs.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/internetConnectivity.dart';
import 'package:mollet/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    checkInternetConnectivity().then((value) => {
          value == true
              ? () {
                  // BrandsNotifier brandsNotifier =
                  //     Provider.of<BrandsNotifier>(context, listen: false);
                  // getBrands(brandsNotifier);

                  ProductsNotifier productsNotifier =
                      Provider.of<ProductsNotifier>(context, listen: false);
                  getProdProducts(productsNotifier);

                  CartNotifier cartNotifier =
                      Provider.of<CartNotifier>(context, listen: false);
                  getCart(cartNotifier);
                }()
              : showNoInternetSnack(_scaffoldKey)
        });

    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
    );

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageStorageBucket searchBucket = PageStorageBucket();

  TabController _tabController;
  final _tabItems = [
    "All",
    "Dogs",
    "Cats",
    "Fish",
    "Birds",
    "Reptiles",
    "Others",
  ];

  @override
  Widget build(BuildContext context) {
    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);
    var prods = productsNotifier.productsList;

    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;
    var cartProdID = cartList.map((e) => e.productID);

    //Tab Items
    final _tabBody = [
      buildAllBody(prods, cartProdID),
      buildDogBody(prods, cartProdID),
      buildCatBody(prods, cartProdID),
      buildDogBody(prods, cartProdID),
      buildCatBody(prods, cartProdID),
      buildDogBody(prods, cartProdID),
      buildCatBody(prods, cartProdID),
    ];

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MColors.primaryWhiteSmoke,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 170.0,
                  enableInfiniteScroll: false,
                  initialPage: 0,
                  viewportFraction: 0.95,
                ),
                items: [1, 2, 3, 4, 5].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        padding: EdgeInsets.all(10),
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
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            "assets/images/petshop-footprint-logo-whiteBg.png",
                            height: 90.0,
                            width: 90.0,
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
      // body: PageStorage(
      //   bucket: searchBucket,
      //   child: Container(
      //     color: MColors.primaryWhiteSmoke,
      //     child: prods.isEmpty
      //         ? progressIndicator(MColors.primaryPurple)
      //         : TabBarView(
      //             physics: BouncingScrollPhysics(),
      //             children: _tabBody,
      //             controller: _tabController,
      //           ),
      //   ),
      // ),
    );
  }

  //Build Tabs
  Widget buildAllBody(prods, cartProdID) {
    Iterable<ProdProducts> all = prods.reversed;
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    ProductsNotifier productsNotifier =
        Provider.of<ProductsNotifier>(context, listen: false);

    return SearchTabWidget(
      prods: all,
      cartNotifier: cartNotifier,
      productsNotifier: productsNotifier,
      cartProdID: cartProdID,
    );
  }

  Widget buildDogBody(prods, cartProdID) {
    Iterable<ProdProducts> dog = prods.where((e) => e.pet == "dog");
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);

    return SearchTabWidget(
      prods: dog,
      cartNotifier: cartNotifier,
      productsNotifier: productsNotifier,
      cartProdID: cartProdID,
    );
  }

  Widget buildCatBody(prods, cartProdID) {
    Iterable<ProdProducts> cat = prods.where((e) => e.pet == "cat");
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);

    return SearchTabWidget(
      prods: cat,
      cartNotifier: cartNotifier,
      productsNotifier: productsNotifier,
      cartProdID: cartProdID,
    );
  }
}
