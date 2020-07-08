import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/notifiers/products_notifier.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/screens/tab_screens/homeScreen_pages/productDetailsScreen.dart';
import 'package:mollet/utils/colors.dart';
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
    ProductsNotifier productsNotifier =
        Provider.of<ProductsNotifier>(context, listen: false);
    getProdProducts(productsNotifier);

    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    getCart(cartNotifier);

    // BrandsNotifier brandsNotifier =
    //     Provider.of<BrandsNotifier>(context, listen: false);
    // getBrands(brandsNotifier);

    UserDataProfileNotifier profileNotifier =
        Provider.of<UserDataProfileNotifier>(context, listen: false);
    getProfile(profileNotifier);

    _tabController = TabController(
      length: _tabItems.length,
      vsync: this,
    );
    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
      appBar: primaryAppBar(
        null,
        null,
        MColors.primaryWhiteSmoke,
        PreferredSize(
          preferredSize: const Size.fromHeight(54),
          child: primaryContainer(
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: primaryTextField(
                    null,
                    null,
                    "Search for products",
                    null,
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
                  ),
                ),
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
              ],
            ),
          ),
        ),
        false,
        null,
      ),
      body: Container(
        color: MColors.primaryWhiteSmoke,
        child: prods.isEmpty
            ? progressIndicator(MColors.primaryPurple)
            : TabBarView(
                children: _tabBody,
                controller: _tabController,
              ),
      ),
    );
  }

  void addToBagshowDialog(
    cartProdID,
    fil,
  ) async {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);

    await showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(
              "Sure you want to add to Bag?",
              style: normalFont(MColors.textDark, null),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "Cancel",
                  style: normalFont(Colors.red, null),
                ),
                onPressed: () async {
                  setState(() {
                    getCart(cartNotifier);
                  });
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(
                  "Yes",
                  style: normalFont(Colors.blue, null),
                ),
                onPressed: () {
                  setState(() {
                    getCart(cartNotifier);
                  });
                  if (cartProdID.contains(fil.productID)) {
                    showSimpleSnack(
                      "Product already in bag",
                      Icons.error_outline,
                      Colors.amber,
                      _scaffoldKey,
                    );
                  } else {
                    addProductToCart(fil);
                    showSimpleSnack(
                      "Product added to bag",
                      Icons.check_circle_outline,
                      Colors.green,
                      _scaffoldKey,
                    );
                    setState(() {
                      getCart(cartNotifier);
                    });
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //Add to Bag dialog
  Widget buildAllBody(prods, cartProdID) {
    Iterable<ProdProducts> all = prods.reversed;

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = size.height / 2.5;
    final double itemWidth = size.width / 2;
    double _picHeight;
    if (itemHeight >= 315) {
      _picHeight = itemHeight / 2;
    } else if (itemHeight <= 315 && itemHeight >= 280) {
      _picHeight = itemHeight / 2.2;
    } else if (itemHeight <= 280 && itemHeight >= 200) {
      _picHeight = itemHeight / 2.7;
    } else {
      _picHeight = 30;
    }

    return primaryContainer(
      GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        children: List<Widget>.generate(all.length, (i) {
          var cleanList = all.toList();
          var fil = cleanList[i];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailsProv(fil, prods),
                ),
              );
            },
            child: Container(
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
              child: Column(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                        child: FadeInImage.assetNetwork(
                          image: fil.productImage,
                          fit: BoxFit.fill,
                          height: _picHeight,
                          placeholder: "assets/images/placeholder.jpg",
                          placeholderScale:
                              MediaQuery.of(context).size.height / 2,
                        ),
                        tag: fil.productID,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      child: Text(
                        fil.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: normalFont(MColors.textDark, 16.0),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "\$${fil.price}",
                            style: boldFont(MColors.primaryPurple, 20.0),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            addToBagshowDialog(
                              cartProdID,
                              fil,
                            );
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: MColors.dashPurple,
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/icons/basket.svg",
                              height: 22.0,
                              color: MColors.textGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildCatBody(prods, cartProdID) {
    Iterable<ProdProducts> cat = prods.where((e) => e.pet == "cat");

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    double _picHeight;
    if (itemHeight >= 315) {
      _picHeight = itemHeight / 2;
    } else if (itemHeight <= 315 && itemHeight >= 280) {
      _picHeight = itemHeight / 2.2;
    } else if (itemHeight <= 280 && itemHeight >= 200) {
      _picHeight = itemHeight / 2.7;
    } else {
      _picHeight = 30;
    }
    return primaryContainer(
      GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        children: List<Widget>.generate(cat.length, (i) {
          var cleanList = cat.toList();
          var fil = cleanList[i];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailsProv(fil, prods),
                ),
              );
            },
            child: Container(
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
              child: Column(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                        child: FadeInImage.assetNetwork(
                          image: fil.productImage,
                          fit: BoxFit.fill,
                          height: _picHeight,
                          placeholder: "assets/images/placeholder.jpg",
                          placeholderScale:
                              MediaQuery.of(context).size.height / 2,
                        ),
                        tag: fil.productID,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      child: Text(
                        fil.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: normalFont(MColors.textDark, 16.0),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "\$${fil.price}",
                            style: boldFont(MColors.primaryPurple, 20.0),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            addToBagshowDialog(
                              cartProdID,
                              fil,
                            );
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: MColors.dashPurple,
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/icons/basket.svg",
                              height: 22.0,
                              color: MColors.textGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget buildDogBody(prods, cartProdID) {
    Iterable<ProdProducts> dog = prods.where((e) => e.pet == "dog");

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 2.5;
    final double itemWidth = size.width / 2;
    double _picHeight;
    if (itemHeight >= 315) {
      _picHeight = itemHeight / 2;
    } else if (itemHeight <= 315 && itemHeight >= 280) {
      _picHeight = itemHeight / 2.2;
    } else if (itemHeight <= 280 && itemHeight >= 200) {
      _picHeight = itemHeight / 2.7;
    } else {
      _picHeight = 30;
    }
    return primaryContainer(
      GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        children: List<Widget>.generate(dog.length, (i) {
          var cleanList = dog.toList();
          var fil = cleanList[i];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailsProv(fil, prods),
                ),
              );
            },
            child: Container(
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
              child: Column(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Hero(
                        child: FadeInImage.assetNetwork(
                          image: fil.productImage,
                          fit: BoxFit.fill,
                          height: _picHeight,
                          placeholder: "assets/images/placeholder.jpg",
                          placeholderScale:
                              MediaQuery.of(context).size.height / 2,
                        ),
                        tag: fil.productID,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      child: Text(
                        fil.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: normalFont(MColors.textDark, 16.0),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "\$${fil.price}",
                            style: boldFont(MColors.primaryPurple, 20.0),
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () {
                            addToBagshowDialog(
                              cartProdID,
                              fil,
                            );
                          },
                          child: Container(
                            width: 40.0,
                            height: 40.0,
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: MColors.dashPurple,
                              borderRadius: new BorderRadius.circular(8.0),
                            ),
                            child: SvgPicture.asset(
                              "assets/images/icons/basket.svg",
                              height: 22.0,
                              color: MColors.textGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
