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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageStorageBucket searchBucket = PageStorageBucket();

  // TextEditingController for searching products
  TextEditingController _searchController = TextEditingController();
  Iterable<ProdProducts> searchList = [];
  var prods;

  TabController _tabController;
  final _tabItems = [
    "Search",
    "All",
    "Dogs",
    "Cats",
    "Fish",
    "Birds",
    "Reptiles",
    "Others",
  ];

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

    // Add listener to searchController
    _searchController.addListener((_onSearchChanged));
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener((_onSearchChanged));
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  // Add callback which is called whenever a text is added to search field
  _onSearchChanged() {
    searchResultsList(prods);
  }

  // Search for the text and match with products
  searchResultsList(List<ProdProducts> allList) {
    List<ProdProducts> showResults = [];

    if (_searchController.text != "") {
      for (var prod in allList) {
        var title = prod.name.toLowerCase();
        if (title.contains(_searchController.text.toLowerCase())) {
          showResults.add(prod);
        }
      }
    } else {
      showResults = allList;
    }
    setState(() {
      searchList = showResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);
    prods = productsNotifier.productsList;

    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;
    var cartProdID = cartList.map((e) => e.productID);

    //Tab Items
    final _tabBody = [
      buildSearchBody(prods, cartProdID),
      buildTypeBody(prods, cartProdID, "all"),
      buildTypeBody(prods, cartProdID, "cat"),
      buildTypeBody(prods, cartProdID, "dog"),
      buildTypeBody(prods, cartProdID, "cat"),
      buildTypeBody(prods, cartProdID, "dog"),
      buildTypeBody(prods, cartProdID, "cat"),
      buildTypeBody(prods, cartProdID, "dog"),
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
            _searchController,
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
  Widget buildTypeBody(prods, cartProdID, type) {
    Iterable<ProdProducts> typeProds =
        type == "all" ? prods.reversed : prods.where((e) => e.pet == type);
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    ProductsNotifier productsNotifier =
        Provider.of<ProductsNotifier>(context, listen: false);

    return SearchTabWidget(
      prods: typeProds,
      cartNotifier: cartNotifier,
      productsNotifier: productsNotifier,
      cartProdID: cartProdID,
    );
  }

  // Search Tab
  Widget buildSearchBody(prods, cartProdID) {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);

    if (searchList.isEmpty) {
      return emptyScreen(
        "assets/images/noSearch.svg",
        "No Search Query",
        "Type a product name in the searchbar above.",
      );
    } else {
      return SearchTabWidget(
        key: UniqueKey(),
        prods: searchList,
        cartNotifier: cartNotifier,
        productsNotifier: productsNotifier,
        cartProdID: cartProdID,
      );
    }
  }
}
