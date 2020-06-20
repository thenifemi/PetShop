import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/cart.dart';
import 'package:mollet/model/notifiers/cart_notifier.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/screens/tab_screens/checkout_screens/addNewAddress.dart';
import 'package:mollet/utils/colors.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  final List<Cart> cartList;
  AddressScreen(this.cartList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserDataAddressNotifier>(
            create: (BuildContext context) => UserDataAddressNotifier(),
          ),
          ChangeNotifierProvider<CartNotifier>(
            create: (context) => CartNotifier(),
          ),
        ],
        child: AddressContainer(cartList),
      ),
    );
  }
}

class AddressContainer extends StatefulWidget {
  final List<Cart> cartList;
  AddressContainer(this.cartList);
  @override
  _AddressContainerState createState() => _AddressContainerState(cartList);
}

class _AddressContainerState extends State<AddressContainer> {
  final List<Cart> cartList;
  _AddressContainerState(this.cartList);
  Future addressFuture;
  @override
  void initState() {
    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context, listen: false);
    addressFuture = getAddress(addressNotifier);
    super.initState();
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showAddressHasUpdated() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Row(
          children: <Widget>[
            Expanded(
              child: Text("Your address has been added"),
            ),
            Icon(
              Icons.check_circle_outline,
              color: Colors.greenAccent,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context);
    var addressList = addressNotifier.userDataAddressList;

    return Scaffold(
      key: _scaffoldKey,
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
          "Check out",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: MColors.primaryWhiteSmoke,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              //Address container
              Container(
                child: FutureBuilder(
                  future: addressFuture,
                  builder: (c, s) {
                    switch (s.connectionState) {
                      case ConnectionState.active:
                        return Container(
                          height: MediaQuery.of(context).size.height / 7,
                          color: MColors.primaryWhiteSmoke,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                          ),
                        );
                        break;
                      case ConnectionState.done:
                        return addressList.isEmpty
                            ? noSavedAddress()
                            : savedAddressWidget();
                        break;
                      case ConnectionState.waiting:
                        return Container(
                          height: MediaQuery.of(context).size.height / 7,
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
                          height: MediaQuery.of(context).size.height / 7,
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
              ),

              SizedBox(
                height: 20.0,
              ),

              //Cart summary container
              Container(
                child: cartSummary(cartList),
              ),
            ],
          ),
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
            onPressed: () {},
            fillColor: MColors.primaryPurple,
            child: Text(
              "Proceed to payment",
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

  Widget savedAddressWidget() {
    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context);
    var addressList = addressNotifier.userDataAddressList;
    var address = addressList.first;

    return Container(
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width,
      // margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: MColors.primaryWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: SvgPicture.asset(
                  "assets/images/icons/Location.svg",
                  color: MColors.primaryPurple,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    "Shipping address",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      color: MColors.textGrey,
                    ),
                  ),
                ),
              ),
              Container(
                width: 50.0,
                height: 14.0,
                child: RawMaterialButton(
                  onPressed: () async {
                    UserDataAddressNotifier addressNotifier =
                        Provider.of<UserDataAddressNotifier>(context,
                            listen: false);
                    var navigationResult = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            AddNewAddress(address, addressList),
                      ),
                    );
                    if (navigationResult == true) {
                      setState(() {
                        getAddress(addressNotifier);
                      });
                      _showAddressHasUpdated();
                    }
                  },
                  child: Text(
                    "Change",
                    style: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        color: MColors.primaryPurple,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    address.fullLegalName,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.0,
                      color: MColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    address.addressLine1 +
                        ", " +
                        address.addressLine2 +
                        ", " +
                        address.city +
                        ", " +
                        address.zipcode +
                        ", " +
                        address.state,
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      color: MColors.textGrey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget noSavedAddress() {
    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context);
    var addressList = addressNotifier.userDataAddressList;

    return Container(
      height: MediaQuery.of(context).size.height / 7,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: MColors.primaryWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Center(
              child: Text(
                "You have no saved address",
                style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  color: MColors.textGrey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Spacer(),
          Container(
            height: 50.0,
            width: MediaQuery.of(context).size.height / 2.8,
            decoration: BoxDecoration(
              color: MColors.dashPurple,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              onPressed: () async {
                UserDataAddressNotifier addressNotifier =
                    Provider.of<UserDataAddressNotifier>(context,
                        listen: false);
                var navigationResult = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddNewAddress(null, addressList),
                  ),
                );
                if (navigationResult == true) {
                  setState(() {
                    getAddress(addressNotifier);
                  });
                }
              },
              child: Center(
                child: Text(
                  "Add a new address",
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    color: MColors.textGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cartSummary(cartList) {
    var totalList = cartList.map((e) => e.totalPrice);
    var total = totalList.isEmpty
        ? 0.0
        : totalList.reduce((sum, element) => sum + element).toStringAsFixed(2);

    return Container(
      height: MediaQuery.of(context).size.height / 3.4,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: MColors.primaryWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: SvgPicture.asset(
                  "assets/images/icons/Bag.svg",
                  color: MColors.primaryPurple,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    "Bag summary",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      color: MColors.textGrey,
                    ),
                  ),
                ),
              ),
              Container(
                width: 50.0,
                height: 14.0,
                child: RawMaterialButton(
                  onPressed: () {
                    _showModalSheet(cartList);
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.montserrat(
                        fontSize: 14.0,
                        color: MColors.primaryPurple,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(25.0, 5.0, 0.0, 0.0),
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: cartList.length < 6 ? cartList.length : 6,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                var cartItem = cartList[i];

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 1.6,
                        child: Text(
                          cartItem.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                          style: GoogleFonts.montserrat(
                            fontSize: 15.0,
                            color: MColors.textGrey,
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Text(cartItem.totalPrice.toStringAsFixed(2),
                            style: GoogleFonts.montserrat(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            )),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 25, top: 5.0),
            child: Row(
              children: <Widget>[
                Text(
                  "Total",
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    color: MColors.primaryPurple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                Text(
                  total,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.0,
                    color: MColors.primaryPurple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showModalSheet(cartList) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          height: MediaQuery.of(context).size.height / 1.5,
          color: Colors.blue,
        );
      },
    );
  }
}