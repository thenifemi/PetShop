import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/utils/cardUtils/cardStrings.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';
import 'package:mollet/credentials.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter/services.dart';

class Address extends StatelessWidget {
  final UserDataAddress address;
  final List<UserDataAddress> addressList;
  Address(this.address, this.addressList);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDataAddressNotifier>(
      create: (context) => UserDataAddressNotifier(),
      child: EnterAddress(address, addressList),
    );
  }
}

class EnterAddress extends StatefulWidget {
  final UserDataAddress address;
  final List<UserDataAddress> addressList;
  EnterAddress(this.address, this.addressList);

  @override
  _EnterAddressState createState() => _EnterAddressState(address, addressList);
}

class _EnterAddressState extends State<EnterAddress> {
  Future addressFuture;
  Future currentLocation;
  var currentLocationAddress;

  final UserDataAddress address;
  final List<UserDataAddress> addressList;
  _EnterAddressState(this.address, this.addressList);
  final formKey = GlobalKey<FormState>();

  TextEditingController _searchController = new TextEditingController();
  Timer _throttle;
  bool showCurrentLocation;
  bool _autoValidate = false;

  @override
  void initState() {
    showCurrentLocation = true;
    _searchController.addListener(_onSearchChanged);

    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context, listen: false);
    addressFuture = getAddress(addressNotifier);

    currentLocation = getUserCurrentLocation(addressNotifier);

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
    _throttle = Timer(const Duration(microseconds: 450), () {
      getLocationResult(_searchController.text, addressNotifier);
    });
  }

  void getLocationResult(
    String input,
    UserDataAddressNotifier addressNotifier,
  ) async {
    if (input.isEmpty || _searchController.text.isEmpty) {
      setState(() {
        showCurrentLocation = true;
      });
      return;
    }

    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String type = '(regions)';

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

  getUserCurrentLocation(
    UserDataAddressNotifier addressNotifier,
  ) async {
    String error;

    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      print('location: ${position.latitude}');
      final coordinates = Coordinates(position.latitude, position.longitude);
      var addresses =
          await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      List<UserDataAddress> _displayResults = [];
      print("${first.featureName} : ${first.addressLine}");

      currentLocationAddress = first.addressLine;
      Map<String, dynamic> asMap() {
        return {
          'addressLocation': currentLocationAddress,
        };
      }

      addressNotifier.userDataAddressList = _displayResults;

      UserDataAddress userDataAddress = UserDataAddress.fromMap(asMap());
      _displayResults.add(userDataAddress);
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        Navigator.pop(context);
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        Navigator.pop(context);

        error = 'permission denied- please enable it from app settings';
        print(error);
      }
    }
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
            Spacer(),
            Container(
              child: FutureBuilder(
                future: addressFuture,
                builder: (c, s) {
                  switch (s.connectionState) {
                    case ConnectionState.active:
                      return Container(
                        height: MediaQuery.of(context).size.height / 7,
                        child: Center(
                            child: progressIndicator(MColors.primaryPurple)),
                      );
                      break;
                    case ConnectionState.done:
                      return addressList == null
                          ? Container()
                          : savedAddressWidget();
                      break;
                    case ConnectionState.waiting:
                      return Container(
                        height: MediaQuery.of(context).size.height / 7,
                        child: Center(
                            child: progressIndicator(MColors.primaryPurple)),
                      );
                      break;
                    default:
                      return Container(
                        height: MediaQuery.of(context).size.height / 7,
                        child: Center(
                            child: progressIndicator(MColors.primaryPurple)),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: warningWidget(),
    );
  }

  Widget useCurrentLocation() {
    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context);
    var _addressList = addressNotifier.userDataAddressList;

    return Column(
      children: <Widget>[
        Center(
          child: Text(
            "Or",
            style: boldFont(MColors.textGrey, 14.0),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          child: FutureBuilder(
            future: currentLocation,
            builder: (c, s) {
              switch (s.connectionState) {
                case ConnectionState.active:
                  return Container(
                    height: MediaQuery.of(context).size.height / 7,
                    child: gettingLocationIndicator(),
                  );
                  break;
                case ConnectionState.done:
                  return currentLocationAddress.isEmpty
                      ? Container()
                      : GestureDetector(
                          onTap: () {
                            var _address = _addressList.first;
                            print(_address.addressLocation);
                            _showModalSheet(_address, true);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: MColors.dashPurple,
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
                                          style:
                                              boldFont(MColors.textDark, 14.0),
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
                                    currentLocationAddress,
                                    style: normalFont(MColors.textGrey, 14.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                  break;
                case ConnectionState.waiting:
                  return Container(
                    height: MediaQuery.of(context).size.height / 7,
                    child: gettingLocationIndicator(),
                  );
                  break;
                default:
                  return Container(
                    height: MediaQuery.of(context).size.height / 7,
                    child: gettingLocationIndicator(),
                  );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget searchResult() {
    UserDataAddressNotifier addressNotifier =
        Provider.of<UserDataAddressNotifier>(context);
    var _addressList = addressNotifier.userDataAddressList;
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
            itemCount: _addressList.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              var _address = _addressList[i];

              return GestureDetector(
                onTap: () {
                  _showModalSheet(_address, false);
                  setState(() {
                    showCurrentLocation = true;
                  });
                  _searchController.clear();
                  FocusScope.of(context).unfocus();
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
                              child: Text(_address.addressLocation),
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

  Widget savedAddressWidget() {
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
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 25.0),
            child: Container(
              child: Text(
                address.addressNumber + ", " + address.addressLocation,
                style: normalFont(MColors.textGrey, 14.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showModalSheet(UserDataAddress _address, bool currentLocation) {
    String _streetNameAndNumber;
    String _name;
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          decoration: BoxDecoration(
            color: MColors.primaryWhiteSmoke,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
          ),
          child: Scaffold(
            backgroundColor: MColors.primaryWhiteSmoke,
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: primaryContainer(
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 10.0),
                      modalBarWidget(),
                      SizedBox(height: 20.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Text(
                          currentLocation == false
                              ? "Please enter your legal name, address name and number, and apt or house number"
                              : "Please enter your legal name and apt or house number",
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
                          _address.addressLocation,
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
                            (String value) =>
                                value.isEmpty ? Strings.fieldReq : null,
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
                              currentLocation == false
                                  ? "Apt or house number and street name and number"
                                  : "Apt or house number",
                              style: normalFont(MColors.textGrey, null),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          primaryTextField(
                            null,
                            null,
                            null,
                            (val) => _streetNameAndNumber = val,
                            true,
                            (String value) =>
                                value.isEmpty ? Strings.fieldReq : null,
                            false,
                            _autoValidate,
                            true,
                            currentLocation == false
                                ? TextInputType.text
                                : TextInputType.number,
                            null,
                            null,
                            0.50,
                          ),
                          SizedBox(height: 5.0),
                          currentLocation == false
                              ? Container(
                                  child: Text(
                                    "Please enter information in order stated above!",
                                    style:
                                        normalFont(MColors.primaryPurple, null),
                                  ),
                                )
                              : Container(),
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

                          _address.addressNumber = _streetNameAndNumber;
                          _address.fullLegalName = _name;

                          addressList == null
                              ? storeAddress(
                                  _address.fullLegalName,
                                  _address.addressLocation,
                                  _address.addressNumber,
                                )
                              : updateAddress(
                                  _address.fullLegalName,
                                  _address.addressLocation,
                                  _address.addressNumber,
                                );

                          Navigator.pop(context);
                          Navigator.pop(context, true);
                        } else {
                          setState(() {
                            _autoValidate = true;
                          });
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
