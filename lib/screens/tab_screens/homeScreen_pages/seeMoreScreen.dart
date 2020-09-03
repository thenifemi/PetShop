import 'package:flutter/material.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/screens/tab_screens/search_screens/search_tabs.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class SeeMoreScreen extends StatefulWidget {
  final List<ProdProducts> products;
  SeeMoreScreen({Key key, this.products}) : super(key: key);

  @override
  _SeeMoreScreenState createState() => _SeeMoreScreenState(products);
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  final List<ProdProducts> products;
  _SeeMoreScreenState(this.products);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: primaryAppBar(
        IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textGrey,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        Text(
          "For you",
          style: boldFont(MColors.primaryPurple, 16.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        null,
      ),
      body: primaryContainer(
        SearchTabWidget(
          prods: dog,
          cartNotifier: cartNotifier,
          productsNotifier: productsNotifier,
          cartProdID: cartProdID,
        ),
      ),
    );
  }
}
