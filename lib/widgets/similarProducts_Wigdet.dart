import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/screens/tab_screens/homeScreen_pages/productDetailsScreen.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

class SimilarProductsWidget extends StatefulWidget {
  final ProdProducts prodDetails;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final UnmodifiableListView<ProdProducts> prods;

  SimilarProductsWidget(
      {Key key, this.prods, this.prodDetails, this.scaffoldKey})
      : super(key: key);

  @override
  _SimilarProductsWidgetState createState() =>
      _SimilarProductsWidgetState(prods, prodDetails, scaffoldKey);
}

class _SimilarProductsWidgetState extends State<SimilarProductsWidget> {
  ProdProducts prodDetails;
  final GlobalKey<ScaffoldState> scaffoldKey;

  UnmodifiableListView<ProdProducts> prods;
  _SimilarProductsWidgetState(this.prods, this.prodDetails, this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    var sims = prods;
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;
    var cartProdID = cartList.map((e) => e.productID);

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
                      scaffoldKey,
                    );
                  } else {
                    addProductToCart(fil);
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
        },
      );
    }

    return Container(
      padding: const EdgeInsets.only(bottom: 5.0),
      height: size.height / 1.38,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        children: List<Widget>.generate(4, (i) {
          Iterable<ProdProducts> iterable = sims
              .where((item) => item.pet == prodDetails.pet)
              .skipWhile((item) => item.productID == prodDetails.productID)
              .toList();

          List<ProdProducts> filteredList = iterable.toList();

          var fil = filteredList[i];

          return GestureDetector(
            onTap: () async {
              CartNotifier cartNotifier =
                  Provider.of<CartNotifier>(context, listen: false);
              var navigationResult = await Navigator.of(context).push(
                CupertinoPageRoute(
                  builder: (context) => ProductDetailsProv(fil, prods),
                ),
              );
              if (navigationResult == true) {
                setState(() {
                  getCart(cartNotifier);
                });
              }
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
                      child: FadeInImage.assetNetwork(
                        image: fil.productImage,
                        fit: BoxFit.fill,
                        height: _picHeight,
                        placeholder: "assets/images/placeholder.jpg",
                        placeholderScale:
                            MediaQuery.of(context).size.height / 2,
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
                        style: normalFont(MColors.textGrey, 14.0),
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
                              borderRadius: BorderRadius.circular(8.0),
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
