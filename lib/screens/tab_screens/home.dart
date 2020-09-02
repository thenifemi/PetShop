import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/notifiers/bannerAd_notifier.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/notifiers/products_notifier.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/internetConnectivity.dart';
import 'package:mollet/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

import 'homeScreen_pages/productDetailsScreen.dart';

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

    ProductsNotifier productsNotifier = Provider.of<ProductsNotifier>(context);
    var prods = productsNotifier.productsList;

    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;
    var cartProdID = cartList.map((e) => e.productID);

    BannerAdNotifier bannerAdNotifier = Provider.of<BannerAdNotifier>(context);
    var bannerAds = bannerAdNotifier.bannerAdsList;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MColors.primaryWhiteSmoke,
      body: SingleChildScrollView(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "POPULAR",
                    style: boldFont(MColors.textDark, 16.0),
                  ),
                  SizedBox(height: 3.0),
                  Text(
                    "Sought after products",
                    style: normalFont(MColors.textGrey, 14.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),

            //POPULAR BLOCK
            Container(
              height: 250.0,
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: prods.length,
                  itemBuilder: (context, i) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      width: 200.0,
                      height: 240.0,
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
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void addToBagshowDialog(
      _product, cartNotifier, cartProdID, scaffoldKey) async {
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
                  if (cartProdID.contains(_product.productID)) {
                    showSimpleSnack(
                      "Product already in bag",
                      Icons.error_outline,
                      Colors.amber,
                      scaffoldKey,
                    );
                  } else {
                    addProductToCart(_product);
                    showSimpleSnack(
                      "Product added to bag",
                      Icons.check_circle_outline,
                      Colors.green,
                      scaffoldKey,
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
}
