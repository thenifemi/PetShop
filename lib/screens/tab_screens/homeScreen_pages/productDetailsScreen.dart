import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/data/Products.dart';
import 'package:mollet/screens/tab_screens/homeScreen_pages/cart2.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/similarProducts_Wigdet.dart';
import 'package:mollet/widgets/allWidgets.dart';
import 'package:mollet/widgets/starRatings.dart';
import 'package:provider/provider.dart';

class ProductDetailsProv extends StatelessWidget {
  final ProdProducts prodDetails;
  final UnmodifiableListView<ProdProducts> prods;
  ProductDetailsProv(this.prodDetails, this.prods);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartNotifier>(
      create: (BuildContext context) => CartNotifier(),
      child: ProductDetails(prodDetails, prods),
    );
  }
}

class ProductDetails extends StatefulWidget {
  final ProdProducts prodDetails;
  final UnmodifiableListView<ProdProducts> prods;
  ProductDetails(this.prodDetails, this.prods);

  @override
  _ProductDetailsState createState() =>
      _ProductDetailsState(prodDetails, prods);
}

class _ProductDetailsState extends State<ProductDetails> {
  _ProductDetailsState(this.prodDetails, this.prods);

  ProdProducts prodDetails;
  UnmodifiableListView<ProdProducts> prods;
  bool _isbuttonDisabled = false;
  bool _isProductadded = false;

  @override
  void initState() {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    getCart(cartNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MColors.primaryWhite,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          var prod = prodDetails;
          return <Widget>[
            SliverAppBar(
              elevation: 0.0,
              brightness: Brightness.light,
              backgroundColor: MColors.primaryWhite,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: MColors.textGrey,
                  size: 22.0,
                ),
                onPressed: () {
                  Navigator.of(context).pop(prod);
                },
              ),
              expandedHeight: (MediaQuery.of(context).size.height) / 2.3,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Builder(
                  builder: (context) {
                    return Container(
                      color: MColors.primaryWhite,
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 10.0),
                      child: prod == null
                          ? Center(child: CircularProgressIndicator())
                          : Hero(
                              child: FadeInImage.assetNetwork(
                                image: prod.productImage,
                                placeholder: "assets/images/placeholder.jpg",
                                placeholderScale:
                                    MediaQuery.of(context).size.height / 2,
                              ),
                              tag: prod.productID,
                            ),
                    );
                  },
                ),
              ),
              actions: <Widget>[
                Container(
                  width: 70,
                  child: RawMaterialButton(
                    child: Container(
                      height: 30.0,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: SvgPicture.asset(
                              "assets/images/icons/Bag.svg",
                              height: 24.0,
                              color: MColors.textGrey,
                            ),
                          ),
                          cartList.isNotEmpty || isCartBadge
                              ? Positioned(
                                  right: 0,
                                  child: new Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: new BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 7,
                                      minHeight: 7,
                                    ),
                                  ),
                                )
                              : Positioned(
                                  right: 0,
                                  child: new Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: new BoxDecoration(
                                      color: MColors.primaryWhite,
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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Cart1(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ];
        },
        body: _buildProductDetails(prodDetails),
      ),
      bottomNavigationBar: Container(
        color: MColors.primaryWhiteSmoke,
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
        child: primaryButtonPurple(
          Text("Add to bag", style: boldFont(MColors.primaryWhite, 16.0)),
          _isbuttonDisabled ? null : () => _submit(cartNotifier),
        ),
      ),
    );
  }

  var quantity = 1;

  Widget _buildProductDetails(prodDetails) {
    void addQty() {
      setState(() {
        if (quantity > 9) {
          quantity = 9;
        } else if (quantity < 9) {
          setState(() {
            quantity++;
          });
        }
      });
    }

    void subQty() {
      setState(() {
        if (quantity != 1) {
          quantity--;
        } else if (quantity < 1) {
          setState(() {
            quantity = 1;
          });
        }
      });
    }

    return Container(
      decoration: BoxDecoration(
        color: MColors.primaryWhiteSmoke,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(20.0),
          topRight: const Radius.circular(20.0),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 20.0,
        right: 20.0,
        left: 20.0,
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              prodDetails.name,
              style: boldFont(MColors.textDark, 22.0),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "\$${prodDetails.price}",
                style: boldFont(MColors.primaryPurple, 20.0),
              ),
            ),
            Builder(builder: (context) {
              return Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: IconTheme(
                          data: IconThemeData(
                            color: Colors.amberAccent,
                            size: 18,
                          ),
                          child: StarDisplay(value: 4),
                        ),
                      ),
                    ),
                    Container(
                      height: 45.0,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: MColors.dashPurple,
                      ),
                      child: Row(children: [
                        Container(
                          width: 35.0,
                          child: RawMaterialButton(
                            onPressed: subQty,
                            child: Icon(
                              Icons.remove,
                              color: MColors.primaryPurple,
                              size: 30.0,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(
                            right: 5.0,
                            left: 5.0,
                          ),
                          child: Text(
                            quantity.toString(),
                            style: boldFont(MColors.textDark, 22.0),
                          ),
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: MColors.primaryPurple,
                          ),
                          width: 35.0,
                          child: RawMaterialButton(
                            onPressed: addQty,
                            child: Icon(
                              Icons.add,
                              color: MColors.primaryWhiteSmoke,
                              size: 30.0,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                "About this product",
                style: boldFont(MColors.textDark, 16.0),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: Text(
                prodDetails.desc,
                style: normalFont(MColors.textGrey, 14.0),
              ),
            ),
            Container(
              child: ExpansionTile(
                title: Text(
                  "More",
                  style: boldFont(MColors.textDark, 16.0),
                ),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      bottom: 10.0,
                      right: 30.0,
                    ),
                    child: Text(
                      prodDetails.moreDesc,
                      style: normalFont(MColors.textGrey, 14.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ExpansionTile(
                title: Text(
                  "Details",
                  style: boldFont(MColors.textDark, 16.0),
                ),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      bottom: 10.0,
                      right: 30.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Food type",
                            style: normalFont(MColors.textDark, 16.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            prodDetails.foodType,
                            style: normalFont(MColors.textGrey, 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      bottom: 10.0,
                      right: 30.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Life stage",
                            style: normalFont(MColors.textDark, 16.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            prodDetails.lifeStage,
                            style: normalFont(MColors.textGrey, 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      bottom: 10.0,
                      right: 30.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Weight",
                            style: normalFont(MColors.textDark, 16.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            prodDetails.weight,
                            style: normalFont(MColors.textGrey, 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      bottom: 10.0,
                      right: 30.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Flavor",
                            style: normalFont(MColors.textDark, 16.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            prodDetails.flavor,
                            style: normalFont(MColors.textGrey, 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ExpansionTile(
                title: Text(
                  "Directions",
                  style: boldFont(MColors.textDark, 16.0),
                ),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      bottom: 10.0,
                      right: 30.0,
                    ),
                    child: Text(
                      prodDetails.directions,
                      style: normalFont(MColors.textGrey, 14.0),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: ExpansionTile(
                title: Text(
                  "Ingredients",
                  style: boldFont(MColors.textDark, 16.0),
                ),
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                      left: 30.0,
                      bottom: 10.0,
                      right: 30.0,
                    ),
                    child: Text(
                      prodDetails.ingredients,
                      style: normalFont(MColors.textGrey, 14.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Text(
                "Similar products",
                style: boldFont(MColors.textDark, 16.0),
              ),
            ),
            SimilarProductsWidget(
              prods: prods,
              prodDetails: prodDetails,
            ),
          ],
        ),
      ),
    );
  }

  //Snakbar

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void disableButton() {
    setState(() {
      _isbuttonDisabled = true;
    });
  }

  bool isCartBadge = false;

  void _submit(cartNotifier) {
    var cartProdID = cartNotifier.cartList.map((e) => e.productID);
    setState(() {
      getCart(cartNotifier);
    });

    try {
      if (cartProdID.contains(prodDetails.productID)) {
        showSimpleSnack(
          "Product already in bag",
          Icons.error_outline,
          Colors.amber,
          _scaffoldKey,
        );
      } else {
        prodDetails.quantity = quantity;
        prodDetails.totalPrice = prodDetails.price * prodDetails.quantity;

        addProductToCart(prodDetails);
        showSimpleSnack(
          "Product added to bag",
          Icons.check_circle_outline,
          Colors.green,
          _scaffoldKey,
        );
        setState(() {
          getCart(cartNotifier);
          isCartBadge = true;
          _isProductadded = true;
        });
      }
    } catch (e) {
      print("ERRORR ==>");
      print(e);
    }
  }
}
