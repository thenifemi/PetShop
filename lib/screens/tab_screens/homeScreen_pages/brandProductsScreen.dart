import 'package:flutter/material.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/model/data/brands.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/notifiers/products_notifier.dart';
import 'package:mollet/screens/tab_screens/search_screens/search_tabs.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class BrandProductsScreen extends StatefulWidget {
  final Brands brand;
  final Iterable<ProdProducts> products;
  final CartNotifier cartNotifier;
  final ProductsNotifier productsNotifier;
  final Iterable<String> cartProdID;

  BrandProductsScreen({
    Key key,
    this.brand,
    this.products,
    this.cartNotifier,
    this.productsNotifier,
    this.cartProdID,
  }) : super(key: key);

  @override
  _BrandProductsScreenState createState() => _BrandProductsScreenState(
      brand, products, cartNotifier, productsNotifier, cartProdID);
}

class _BrandProductsScreenState extends State<BrandProductsScreen> {
  final Brands brand;
  final Iterable<ProdProducts> products;
  final CartNotifier cartNotifier;
  final ProductsNotifier productsNotifier;
  final Iterable<String> cartProdID;

  _BrandProductsScreenState(
    this.brand,
    this.products,
    this.cartNotifier,
    this.productsNotifier,
    this.cartProdID,
  );

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
          brand.brandName,
          style: boldFont(MColors.primaryPurple, 16.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        null,
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              child: Hero(
                tag: brand.brandName,
                child: FadeInImage.assetNetwork(
                  image: brand.brandImage,
                  fit: BoxFit.fill,
                  placeholder: "assets/images/placeholder.jpg",
                  placeholderScale: MediaQuery.of(context).size.width / 2,
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Expanded(
              child: SearchTabWidget(
                prods: products,
                cartNotifier: cartNotifier,
                productsNotifier: productsNotifier,
                cartProdID: cartProdID,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
