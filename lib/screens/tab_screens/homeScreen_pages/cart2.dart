import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  Widget cart(cartList, total) {
    return Scaffold(
      key: _scaffoldKey,
      body: primaryContainer(
        Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "${cartList.length} Items",
                    style: normalFont(MColors.textGrey, 14.0),
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "\$$total",
                    style: boldFont(MColors.textGrey, 22.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Expanded(
              child: Container(
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
                      background:
                          backgroundDismiss(AlignmentDirectional.centerStart),
                      secondaryBackground:
                          backgroundDismiss(AlignmentDirectional.centerEnd),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 5.0),
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Text(
                                        cartItem.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            normalFont(MColors.textDark, 16.0),
                                        textAlign: TextAlign.left,
                                        softWrap: true,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "\$${cartItem.price}",
                                            style: boldFont(
                                                MColors.primaryPurple, 22.0),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(3.0),
                                            decoration: BoxDecoration(
                                              color: MColors.dashPurple,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Text(
                                              "${cartItem.quantity}X",
                                              style: normalFont(
                                                  MColors.textGrey, 14.0),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.info_outline,
                                            color: Colors.redAccent,
                                            size: 14.0,
                                          ),
                                          SizedBox(
                                            width: 2.0,
                                          ),
                                          Container(
                                            child: Text(
                                              "Swipe to remove",
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: normalFont(
                                                  Colors.redAccent, 10.0),
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
                              Spacer(),
                              Builder(
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
                                                new BorderRadius.circular(10.0),
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
                                              color: MColors.primaryWhiteSmoke,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                            child: Text(
                                              cartItem.quantity.toString(),
                                              style: normalFont(
                                                  MColors.textDark, 18.0),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                new BorderRadius.circular(10.0),
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
        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
        child: primaryButtonPurple(
          Text("Proceed to checkout",
              style: boldFont(MColors.primaryWhite, 16.0)),
          () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddressScreen(cartList),
              ),
            );
          },
        ),
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
                textStyle: normalFont(Colors.red, null),
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
}
