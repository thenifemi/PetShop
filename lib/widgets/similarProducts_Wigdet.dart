import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/screens/tab_screens/homeScreen_pages/productDetailsScreen.dart';
import 'package:mollet/screens/tab_screens/search_screens/search_tabs.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';
import 'package:provider/provider.dart';

class SimilarProductsWidget extends StatefulWidget {
  final ProdProducts prodDetails;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final Iterable<ProdProducts> prods;

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

  Iterable<ProdProducts> prods;
  _SimilarProductsWidgetState(this.prods, this.prodDetails, this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    var sims = prods;
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    var cartList = cartNotifier.cartList;
    var cartProdID = cartList.map((e) => e.productID);

    return SearchTabWidget(
      prods: sims,
      cartNotifier: cartNotifier,
      cartProdID: cartProdID,
    );
  }
}
