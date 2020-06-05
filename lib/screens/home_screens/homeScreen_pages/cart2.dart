import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/prodModel/Product_service.dart';
import 'package:mollet/prodModel/cart_notifier.dart';
import 'package:mollet/utils/colors.dart';
import 'package:provider/provider.dart';

class Cart1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartNotifier>(
      create: (BuildContext context) => CartNotifier(),
      child: Cart2(),
    );
  }
}

class Cart2 extends StatefulWidget {
  @override
  _Cart2State createState() => _Cart2State();
}

class _Cart2State extends State<Cart2> {
  Future cartFuture;

  @override
  void initState() {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);
    cartFuture = getCart(cartNotifier);
    getCart(cartNotifier);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartNotifier cartNotifier = Provider.of<CartNotifier>(context);
    var cartList = cartNotifier.cartList;
    var totalList = cartNotifier.cartList.map((e) => e.price);
    var total = totalList.isEmpty
        ? 0.0
        : totalList.reduce((sum, element) => sum + element).toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: MColors.primaryWhiteSmoke,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: MColors.textDark,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Bag",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: cartFuture,
        builder: (c, s) {
          switch (s.connectionState) {
            case ConnectionState.active:
              return Container(
                color: MColors.primaryWhiteSmoke,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
              break;
            case ConnectionState.done:
              return cartList.isEmpty ? emptyCart() : cart(cartList, total);
              break;
            case ConnectionState.waiting:
              return Container(
                color: MColors.primaryWhiteSmoke,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
              break;
            default:
              return Container(
                color: MColors.primaryWhiteSmoke,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  Widget cart(cartList, total) {
    return Scaffold(
      body: Container(
        color: MColors.primaryWhite,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
              height: 70,
              color: MColors.primaryWhiteSmoke,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "${cartList.length} Items",
                    style: GoogleFonts.montserrat(
                      color: MColors.textGrey,
                      fontSize: 14.0,
                      // fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    "\$$total",
                    style: GoogleFonts.montserrat(
                      color: MColors.textGrey,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: MColors.primaryWhiteSmoke,
                padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cartList.length,
                  itemBuilder: (context, i) {
                    var cartItem = cartList[i];
                    var cartItemTotal = cartItem.price * cartItem.quantity;

                    var qty = cartItem.quantity;

                    void addQty() {
                      setState(() {
                        if (qty > 9) {
                          qty = 9;
                        } else if (qty < 9) {
                          setState(() {
                            qty++;
                          });
                        }
                      });
                    }

                    void subQty() {
                      setState(() {
                        if (qty != 1) {
                          qty--;
                        } else if (qty < 1) {
                          setState(() {
                            qty = 1;
                          });
                        }
                      });
                    }

                    return Container(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      height: 160.0,
                      child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: MColors.primaryWhite,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 80.0,
                              child: FadeInImage.assetNetwork(
                                image: cartItem.productImage,
                                fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height,
                                placeholder: "assets/images/placeholder.jpg",
                                placeholderScale:
                                    MediaQuery.of(context).size.height / 2,
                              ),
                            ),
                            Container(
                              width: 220.0,
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(5.0),
                                    width: 200.0,
                                    child: Text(
                                      cartItem.name,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          fontSize: 16.0,
                                          color: MColors.textDark,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "\$$cartItemTotal",
                                      style: GoogleFonts.montserrat(
                                          fontSize: 24.0,
                                          color: MColors.primaryPurple,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        0.0, 0.0, 10.0, 10.0),
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.info_outline,
                                          color: Colors.redAccent,
                                          size: 14.0,
                                        ),
                                        SizedBox(
                                          width: 3.0,
                                        ),
                                        Container(
                                          width: 180.0,
                                          child: Text(
                                            "Swipe to remove",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.montserrat(
                                              fontSize: 10.0,
                                              color: Colors.redAccent,
                                            ),
                                            textAlign: TextAlign.left,
                                            softWrap: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: StreamBuilder(
                                  stream: null,
                                  builder: (context, snapshot) {
                                    return Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: IconButton(
                                              color: MColors.textGrey,
                                              icon: Icon(
                                                  Icons.add_circle_outline),
                                              onPressed: addQty,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              qty.toString(),
                                              style: GoogleFonts.montserrat(
                                                color: MColors.textDark,
                                                fontSize: 20.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: IconButton(
                                              color: MColors.textGrey,
                                              icon: Icon(
                                                  Icons.remove_circle_outline),
                                              onPressed: subQty,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: MColors.primaryWhite,
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 15.0),
        height: 80.0,
        child: SizedBox(
          width: double.infinity,
          height: 60.0,
          child: RawMaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            onPressed: () {},
            fillColor: MColors.primaryPurple,
            child: Text(
              "Proceed to checkout",
              style: GoogleFonts.montserrat(
                color: MColors.primaryWhite,
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget emptyCart() {
    return Container(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                child: SvgPicture.asset(
                  "assets/images/emptyCart.svg",
                  height: 150,
                ),
              ),
              Container(
                child: Text(
                  "Cart is empty",
                  style: GoogleFonts.montserrat(
                    color: MColors.textDark,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  right: 30.0,
                  left: 30.0,
                  top: 10.0,
                ),
                child: Text(
                  "Products that you add to your cart will show up here. So lets get shopping.",
                  style: GoogleFonts.montserrat(
                    color: MColors.textGrey,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
