import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/services/Product_service.dart';
import 'package:mollet/screens/tab_screens/checkout_screens/completeOrder.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    var totalList = cartList.map((e) => e.totalPrice);
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
              return progressIndicator(MColors.primaryPurple);
              break;
            case ConnectionState.done:
              return cartList.isEmpty ? emptyCart() : cart(cartList, total);
              break;
            case ConnectionState.waiting:
              return progressIndicator(MColors.primaryPurple);
              break;
            default:
              return progressIndicator(MColors.primaryPurple);
          }
        },
      ),
    );
  }

  //Remove from cart

  Future<bool> promptUser(cartItem) async {
    CartNotifier cartNotifier =
        Provider.of<CartNotifier>(context, listen: false);

    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text("Are you sure you want to remove?"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                  getCart(cartNotifier);
                },
              ),
              CupertinoDialogAction(
                child: Text("Yes"),
                textStyle: GoogleFonts.montserrat(color: Colors.redAccent),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  removeItemFromCart(cartItem);
                  getCart(cartNotifier);
                },
              ),
            ],
          ),
        ) ??
        false;
  }
  //

  Widget cart(cartList, total) {
    return Scaffold(
      key: _scaffoldKey,
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
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: cartList.length,
                  itemBuilder: (context, i) {
                    var cartItem = cartList[i];

                    return Dismissible(
                      key: UniqueKey(),
                      confirmDismiss: (direction) => promptUser(cartItem),
                      onDismissed: (direction) {
                        cartList.remove(UniqueKey());
                        showSimpleSnack(
                          "Product removed from bag",
                          Icons.error_outline,
                          Colors.amber,
                          _scaffoldKey,
                        );
                      },
                      background: Container(
                        color: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        alignment: AlignmentDirectional.centerStart,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        color: Colors.redAccent,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        alignment: AlignmentDirectional.centerEnd,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(5.0),
                        height: 160.0,
                        child: Container(
                          padding: const EdgeInsets.all(15.0),
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
                                padding: const EdgeInsets.only(left: 3.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(5.0),
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      child: Text(
                                        cartItem.name,
                                        maxLines: 2,
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
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "\$${cartItem.price}",
                                            style: GoogleFonts.montserrat(
                                                fontSize: 24.0,
                                                color: MColors.primaryPurple,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              decoration: BoxDecoration(
                                                color: MColors.dashPurple,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10.0),
                                              ),
                                              child: Text(
                                                "${cartItem.quantity}X",
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 14.0,
                                                    color: MColors.textGrey),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: const EdgeInsets.fromLTRB(
                                          0.0, 0.0, 0.0, 10.0),
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
                                child: Builder(
                                  builder: (context) {
                                    CartNotifier cartNotifier =
                                        Provider.of<CartNotifier>(context,
                                            listen: false);

                                    return Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0),
                                              color: MColors.primaryPurple,
                                            ),
                                            height: 34.0,
                                            width: 34.0,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                addAndApdateData(cartItem);
                                                getCart(cartNotifier);
                                              },
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                    MColors.primaryWhiteSmoke,
                                                size: 24.0,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Center(
                                              child: Text(
                                                cartItem.quantity.toString(),
                                                style: GoogleFonts.montserrat(
                                                  color: MColors.textDark,
                                                  fontSize: 20.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      10.0),
                                              color: MColors.primaryWhiteSmoke,
                                            ),
                                            width: 34.0,
                                            height: 34.0,
                                            child: RawMaterialButton(
                                              onPressed: () {
                                                subAndApdateData(cartItem);
                                                getCart(cartNotifier);
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                color: MColors.primaryPurple,
                                                size: 30.0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
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
        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        height: 80.0,
        child: SizedBox(
          width: double.infinity,
          height: 60.0,
          child: RawMaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddressScreen(cartList),
                ),
              );
            },
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
