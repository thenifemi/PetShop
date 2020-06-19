import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/screens/tab_screens/checkout_screens/addNewAddress.dart';
import 'package:mollet/utils/colors.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChangeNotifierProvider<UserDataAddressNotifier>(
          create: (BuildContext context) => UserDataAddressNotifier(),
          child: AddressContainer()),
    );
  }
}

class AddressContainer extends StatefulWidget {
  @override
  _AddressContainerState createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
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
    // var address = addressList.first;

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
          "Complete order",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: addressFuture,
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
                return addressList.isEmpty
                    ? noSavedAddress()
                    : savedAddressWidget();
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
          }),
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
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      color: MColors.primaryWhiteSmoke,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 6,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: SvgPicture.asset(
                          "assets/images/icons/Location.svg",
                          height: 20,
                          color: MColors.primaryPurple,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            "Delivery address",
                            style: GoogleFonts.montserrat(
                              fontSize: 14.0,
                              color: MColors.textGrey,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 50.0,
                        child: RawMaterialButton(
                          onPressed: () async {
                            UserDataAddressNotifier addressNotifier =
                                Provider.of<UserDataAddressNotifier>(context,
                                    listen: false);
                            var navigationResult =
                                await Navigator.of(context).push(
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
                          padding: const EdgeInsets.only(bottom: 10.0),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget noSavedAddress() {
    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context);
    var addressList = addressNotifier.userDataAddressList;
    var address = addressList.first;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      color: MColors.primaryWhiteSmoke,
      height: double.infinity,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
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
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Center(
                      child: Text(
                        "No saved address",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          color: MColors.textGrey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: SvgPicture.asset(
                      "assets/images/address.svg",
                      height: MediaQuery.of(context).size.height / 5,
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
                            builder: (context) =>
                                AddNewAddress(address, addressList),
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
            ),
          ],
        ),
      ),
    );
  }
}
