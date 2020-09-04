import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/notifiers/bannerAd_notifier.dart';
import 'package:mollet/model/notifiers/brands_notifier.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/notifiers/products_notifier.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/screens/tab_screens/homeScreen_pages/brandProductsScreen.dart';
import 'package:mollet/screens/tab_screens/homeScreen_pages/seeMoreScreen.dart';
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

                  BannerAdNotifier bannerAdNotifier =
                      Provider.of<BannerAdNotifier>(context, listen: false);
                  getBannerAds(bannerAdNotifier);
                }()
              : showNoInternetSnack(_scaffoldKey)
        });

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageStorageBucket searchBucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height) / 2.5;
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

    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);
    var prods = productsNotifier.productsList;

    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;
    var cartProdID = cartList.map((e) => e.productID);

    BannerAdNotifier bannerAdNotifier = Provider.of<BannerAdNotifier>(context);
    var bannerAds = bannerAdNotifier.bannerAdsList;

    BrandsNotifier brandsNotifier = Provider.of<BrandsNotifier>(context);
    var brands = brandsNotifier.brandsList;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MColors.primaryWhiteSmoke,
      body: RefreshIndicator(
        onRefresh: () => () {
          getProdProducts(productsNotifier);
          getCart(cartNotifier);
          getBannerAds(bannerAdNotifier);
          getBrands(brandsNotifier);
        }(),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //BANNER ADS
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 170.0,
                    enableInfiniteScroll: false,
                    initialPage: 0,
                    viewportFraction: 0.95,
                    scrollPhysics: BouncingScrollPhysics(),
                  ),
                  items: bannerAds.map((banner) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                            child: FadeInImage.assetNetwork(
                              image: banner.bannerAd,
                              fit: BoxFit.fill,
                              placeholder: "assets/images/placeholder.jpg",
                              placeholderScale:
                                  MediaQuery.of(context).size.width / 2,
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 20),

              //FOR YOU BLOCK
              Builder(
                builder: (BuildContext context) {
                  Iterable<ProdProducts> forYou =
                      prods.where((e) => e.tag == "forYou");
                  var _prods = forYou.toList();

                  return blockWigdet(
                    "FOR YOU",
                    "Products you might like",
                    _picHeight,
                    itemHeight,
                    _prods,
                    cartNotifier,
                    cartProdID,
                    _scaffoldKey,
                    context,
                    prods,
                    () async {
                      var title = "For you";
                      var navigationResult = await Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => SeeMoreScreen(
                            title: title,
                            products: prods,
                            productsNotifier: productsNotifier,
                            cartNotifier: cartNotifier,
                            cartProdID: cartProdID,
                          ),
                        ),
                      );
                      if (navigationResult == true) {
                        getCart(cartNotifier);
                      }
                    },
                  );
                },
              ),

              SizedBox(height: 20),

              //POPULAR BLOCK
              Builder(
                builder: (BuildContext context) {
                  Iterable<ProdProducts> popular =
                      prods.where((e) => e.tag == "popular");
                  var _prods = popular.toList();

                  return blockWigdet(
                    "POPULAR",
                    "Sought after products",
                    _picHeight,
                    itemHeight,
                    _prods,
                    cartNotifier,
                    cartProdID,
                    _scaffoldKey,
                    context,
                    prods,
                    () async {
                      var title = "Popular";

                      var navigationResult = await Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => SeeMoreScreen(
                            title: title,
                            products: prods,
                            productsNotifier: productsNotifier,
                            cartNotifier: cartNotifier,
                            cartProdID: cartProdID,
                          ),
                        ),
                      );
                      if (navigationResult == true) {
                        getCart(cartNotifier);
                      }
                    },
                  );
                },
              ),

              SizedBox(height: 20),

              //NEW BLOCK
              Builder(
                builder: (BuildContext context) {
                  Iterable<ProdProducts> newP =
                      prods.where((e) => e.tag == "new");
                  var _prods = newP.toList();

                  return blockWigdet(
                    "NEW",
                    "Newly released products",
                    _picHeight,
                    itemHeight,
                    _prods,
                    cartNotifier,
                    cartProdID,
                    _scaffoldKey,
                    context,
                    prods,
                    () async {
                      var title = "New";

                      var navigationResult = await Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => SeeMoreScreen(
                            title: title,
                            products: prods,
                            productsNotifier: productsNotifier,
                            cartNotifier: cartNotifier,
                            cartProdID: cartProdID,
                          ),
                        ),
                      );
                      if (navigationResult == true) {
                        getCart(cartNotifier);
                      }
                    },
                  );
                },
              ),

              SizedBox(height: 20),

              //BRANDS
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Text(
                        "POPULAR BRANDS",
                        style: boldFont(MColors.textDark, 16.0),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        enableInfiniteScroll: false,
                        initialPage: 0,
                        viewportFraction: 0.95,
                        scrollPhysics: BouncingScrollPhysics(),
                      ),
                      items: brands.map((brand) {
                        return Builder(
                          builder: (BuildContext context) {
                            return GestureDetector(
                              onTap: () async {
                                var navigationResult =
                                    await Navigator.of(context).push(
                                  CupertinoPageRoute(
                                      builder: (context) => BrandProductsScreen(
                                            brand: brand,
                                            products: prods,
                                            cartNotifier: cartNotifier,
                                            productsNotifier: productsNotifier,
                                            cartProdID: cartProdID,
                                          )),
                                );
                                if (navigationResult == true) {
                                  getCart(cartNotifier);
                                }
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                                  child: Hero(
                                    tag: brand.brandName,
                                    child: FadeInImage.assetNetwork(
                                      image: brand.brandImage,
                                      fit: BoxFit.fill,
                                      placeholder:
                                          "assets/images/placeholder.jpg",
                                      placeholderScale:
                                          MediaQuery.of(context).size.width / 2,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              //OFFERS
              Builder(
                builder: (BuildContext context) {
                  Iterable<ProdProducts> offers =
                      prods.where((e) => e.tag == "offers");
                  var _prods = offers.toList();

                  return blockWigdet(
                    "OFFERS",
                    "Slashed prices just for you",
                    _picHeight,
                    itemHeight,
                    _prods,
                    cartNotifier,
                    cartProdID,
                    _scaffoldKey,
                    context,
                    prods,
                    () async {
                      var title = "Offers";

                      var navigationResult = await Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => SeeMoreScreen(
                            title: title,
                            products: prods,
                            productsNotifier: productsNotifier,
                            cartNotifier: cartNotifier,
                            cartProdID: cartProdID,
                          ),
                        ),
                      );
                      if (navigationResult == true) {
                        getCart(cartNotifier);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
