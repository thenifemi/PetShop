import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petShop/model/data/Products.dart';
import 'package:petShop/model/notifiers/brands_notifier.dart';
import 'package:petShop/model/notifiers/cart_notifier.dart';
import 'package:petShop/model/notifiers/products_notifier.dart';
import 'package:petShop/model/services/Product_service.dart';
import 'package:petShop/screens/tab_screens/search_screens/search_tabs.dart';
import 'package:petShop/utils/colors.dart';
import 'package:petShop/utils/internetConnectivity.dart';
import 'package:petShop/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => BrandsNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartNotifier(),
        ),
      ],
      child: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
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
      appBar: primaryAppBar(
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textGrey,
          ),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
        Container(
          height: 40.0,
          child: searchTextField(
            true,
            null,
            null,
            "Search for products...",
            null,
            null,
            true,
            null,
            false,
            false,
            true,
            TextInputType.text,
            null,
            SvgPicture.asset(
              "assets/images/icons/Search.svg",
              color: MColors.textGrey,
              height: 16.0,
            ),
            0.0,
          ),
        ),
        MColors.primaryWhiteSmoke,
        TabBar(
          unselectedLabelColor: MColors.textGrey,
          unselectedLabelStyle: normalFont(MColors.textGrey, 16.0),
          labelColor: MColors.primaryPurple,
          labelStyle: boldFont(MColors.primaryPurple, 20.0),
          indicatorWeight: 0.01,
          isScrollable: true,
          tabs: _tabItems.map((e) {
            return Tab(
              child: Text(
                e,
              ),
            );
          }).toList(),
          controller: _tabController,
        ),
        false,
        null,
      ),
      body: Scaffold(
        key: _scaffoldKey,
        body: PageStorage(
          bucket: searchBucket,
          child: Container(
            color: MColors.primaryWhiteSmoke,
            child: prods.isEmpty
                ? progressIndicator(MColors.primaryPurple)
                : TabBarView(
                    physics: BouncingScrollPhysics(),
                    children: _tabBody,
                    controller: _tabController,
                  ),
          ),
        ),
      ),
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
