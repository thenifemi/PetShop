import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petShop/model/data/Products.dart';
import 'package:petShop/model/data/brands.dart';
import 'package:petShop/model/notifiers/cart_notifier.dart';
import 'package:petShop/model/notifiers/products_notifier.dart';
import 'package:petShop/model/services/Product_service.dart';
import 'package:petShop/screens/tab_screens/search_screens/search_tabs.dart';
import 'package:petShop/utils/colors.dart';
import 'package:petShop/widgets/allWidgets.dart';

import 'bag.dart';

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
    var cartList = cartNotifier.cartList;

    return Scaffold(
      backgroundColor: MColors.primaryWhiteSmoke,
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
        [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            width: 50,
            child: RawMaterialButton(
              onPressed: () async {
                var navigationResult = await Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (context) => Bag(),
                  ),
                );
                if (navigationResult == true) {
                  setState(() {
                    getCart(cartNotifier);
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.only(left: 10.0),
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: SvgPicture.asset(
                        "assets/images/icons/Bag.svg",
                        height: 25,
                        color: MColors.textGrey,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: cartList.isNotEmpty
                              ? Colors.redAccent
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 7,
                          minHeight: 7,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
