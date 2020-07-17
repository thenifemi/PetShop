import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/utils/cardUtils/cardStrings.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/textFieldFormaters.dart';
import 'package:mollet/widgets/allWidgets.dart';
import 'package:mollet/credentials.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class Address extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDataAddressNotifier>(
      create: (context) => UserDataAddressNotifier(),
      child: EnterAddress(),
    );
  }
}

class EnterAddress extends StatefulWidget {
  @override
  _EnterAddressState createState() => _EnterAddressState();
}

class _EnterAddressState extends State<EnterAddress> {
  final formKey = GlobalKey<FormState>();

  TextEditingController _searchController = new TextEditingController();
  Timer _throttle;
  bool showCurrentLocation;
  bool _autoValidate = false;

  @override
  void initState() {
    showCurrentLocation = true;
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  _onSearchChanged() {
    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context, listen: false);

    if (_throttle?.isActive ?? false) _throttle.cancel();
    _throttle = Timer(const Duration(microseconds: 400), () {
      getLocationResult(_searchController.text, addressNotifier);
    });
  }

  void getLocationResult(
      String input, UserDataAddressNotifier addressNotifier) async {
    if (input.isEmpty || _searchController.text.isEmpty) {
      setState(() {
        showCurrentLocation = true;
      });
      return;
    }

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';
    //TODO Add session token

    String request = '$baseURL?input=$input&key=$PLACES_API_KEY&type=$type';
    Response response = await Dio().get(request);
    final predictions = response.data['predictions'];

    List<UserDataAddress> _displayResults = [];

    for (var i = 0; i < predictions.length; i++) {
      String addressLocation = predictions[i]['description'];
      String addressNumber;
      String fullLegalName;

      Map<String, dynamic> asMap() {
        return {
          'addressLocation': addressLocation,
          'addressNumber': addressNumber,
          'fullLegalName': fullLegalName,
        };
      }

      UserDataAddress userDataAddress = UserDataAddress.fromMap(asMap());
      _displayResults.add(userDataAddress);
    }
    addressNotifier.userDataAddressList = _displayResults;

    setState(() {
      showCurrentLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          "Shipping address",
          style: boldFont(MColors.primaryPurple, 16.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        null,
      ),
      body: primaryContainer(
        Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    child: searchTextField(
                      _searchController,
                      null,
                      "Search for your address",
                      null,
                      null,
                      true,
                      null,
                      false,
                      false,
                      true,
                      TextInputType.text,
                      null,
                      SvgPicture.asset(
                        "assets/images/icons/Search.svg",
                        color: MColors.textGrey,
                        height: 16.0,
                      ),
                      0.0,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  showCurrentLocation == true
                      ? useCurrentLocation()
                      : searchResult(),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Divider(height: 1.0),
            SizedBox(height: 20.0),
            Container(
              width: MediaQuery.of(context).size.width,
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
                          "assets/images/icons/Home.svg",
                          color: MColors.primaryPurple,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Expanded(
                        child: Container(
                          child: Text(
                            "Saved address",
                            style: boldFont(MColors.textDark, 14.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 60.0,
                        height: 25.0,
                        child: RawMaterialButton(
                          onPressed: () async {
                            // UserDataAddressNotifier addressNotifier =
                            //     Provider.of<UserDataAddressNotifier>(context,
                            //         listen: false);
                            // var navigationResult =
                            //     await Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         AddNewAddress(address, addressList),
                            //   ),
                            // );
                            // if (navigationResult == true) {
                            //   setState(() {
                            //     getAddress(addressNotifier);
                            //   });
                            //   showSimpleSnack(
                            //     "Address has been updated",
                            //     Icons.check_circle_outline,
                            //     Colors.green,
                            //     _scaffoldKey,
                            //   );
                            // }
                          },
                          child: Text(
                            "select",
                            style: boldFont(MColors.primaryPurple, 14.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 25.0),
                    child: Container(
                      child: Text(
                        "Apt 1902, Bela Monte Condo, Rua João Pedro, Centro, Blumenau - SC",
                        style: normalFont(MColors.textGrey, 14.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: warningWidget(),
    );
  }

  Widget useCurrentLocation() {
    return Column(
      children: <Widget>[
        Center(
          child: Text(
            "Or",
            style: boldFont(MColors.textGrey, 14.0),
          ),
        ),
        SizedBox(height: 10.0),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: MColors.primaryWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: SvgPicture.asset(
                        "assets/images/icons/Discovery.svg",
                        color: MColors.primaryPurple,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Container(
                        child: Text(
                          "Use current location",
                          style: boldFont(MColors.textDark, 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                  ),
                  child: Text(
                    "Apt 1902, Bela Monte Condo, Rua João Pedro, Centro",
                    style: normalFont(MColors.textGrey, 14.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget searchResult() {
    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context);
    var addressList = addressNotifier.userDataAddressList;
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: MColors.primaryWhite,
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      child: Column(
        children: <Widget>[
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: addressList.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              var address = addressList[i];

              return GestureDetector(
                onTap: () {
                  _showModalSheet(address);
                  setState(() {
                    showCurrentLocation = true;
                  });
                  _searchController.clear();
                },
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 40.0,
                        child: Row(
                          children: <Widget>[
                            Container(
                              child: SvgPicture.asset(
                                "assets/images/icons/Location.svg",
                                color: MColors.primaryPurple,
                              ),
                            ),
                            SizedBox(width: 5.0),
                            Expanded(
                              child: Text(address.addressLocation),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10.0),
          Container(
            child: GestureDetector(
              onTap: () {
                _searchController.clear();
                setState(() {
                  showCurrentLocation = true;
                });
              },
              child: Text(
                "Close",
                style: boldFont(MColors.primaryPurple, 14.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModalSheet(UserDataAddress address) {
    String _number;
    String _name;
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return primaryContainer(
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Text(
                    "Please enter your legal name and address number",
                    style: boldFont(MColors.textDark, 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 30.0,
                  child: SvgPicture.asset(
                    "assets/images/icons/Location.svg",
                    color: MColors.primaryPurple,
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    address.addressLocation,
                    style: normalFont(MColors.textGrey, 14.0),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Full legal name",
                        style: normalFont(MColors.textGrey, null),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    primaryTextField(
                      null,
                      null,
                      null,
                      (val) => _name = val,
                      true,
                      (String value) => value.isEmpty ? Strings.fieldReq : null,
                      false,
                      _autoValidate,
                      true,
                      TextInputType.text,
                      null,
                      null,
                      0.50,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Number",
                        style: normalFont(MColors.textGrey, null),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    primaryTextField(
                      null,
                      null,
                      null,
                      (val) => _number = val,
                      true,
                      (String value) => value.isEmpty ? Strings.fieldReq : null,
                      false,
                      _autoValidate,
                      true,
                      TextInputType.number,
                      null,
                      null,
                      0.50,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                primaryButtonPurple(
                    Text(
                      "Save",
                      style: boldFont(
                        MColors.primaryWhite,
                        16.0,
                      ),
                    ), () {
                  final form = formKey.currentState;
                  if (form.validate()) {
                    form.save();

                    address.addressNumber = _number;
                    address.fullLegalName = _name;

                    print(address.fullLegalName +
                        address.addressNumber +
                        address.addressLocation);

                    int count = 0;
                    Navigator.of(context).popUntil((_) => count++ >= 2);
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });
                  }
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
