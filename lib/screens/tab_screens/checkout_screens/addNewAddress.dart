import 'package:flutter/material.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/cardUtils/cardStrings.dart';
import 'package:mollet/widgets/allWidgets.dart';

class AddNewAddress extends StatefulWidget {
  final UserDataAddress address;
  final List<UserDataAddress> addressList;

  AddNewAddress(this.address, this.addressList);

  @override
  _AddNewAddressState createState() =>
      _AddNewAddressState(address, addressList);
}

class _AddNewAddressState extends State<AddNewAddress> {
  UserDataAddress address;
  List<UserDataAddress> addressList;

  _AddNewAddressState(this.address, this.addressList);

  String _fullLegalName;
  String _addressLine1;
  String _addressLine2;
  String _city;
  String _zipcode;
  String _state;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  var _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
          style: boldFont(MColors.primaryPurple, 18.0),
        ),
        MColors.primaryWhiteSmoke,
        null,
        true,
        null,
      ),
      body: primaryContainer(
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            autovalidate: _autoValidate,
            child: Container(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Full legal name",
                        style: normalFont(MColors.textGrey, null),
                      ),
                      SizedBox(height: 5.0),
                      primaryTextField(
                        null,
                        addressList.isEmpty ? "" : address.fullLegalName,
                        "",
                        (val) => _fullLegalName = val,
                        true,
                        (String value) =>
                            value.isEmpty ? Strings.fieldReq : null,
                        false,
                        _autoValidate,
                        false,
                        TextInputType.text,
                        null,
                        null,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Address line 1",
                        style: normalFont(MColors.textGrey, null),
                      ),
                      SizedBox(height: 5.0),
                      primaryTextField(
                        null,
                        addressList.isEmpty ? "" : address.addressLine1,
                        "",
                        (val) => _addressLine1 = val,
                        true,
                        (String value) =>
                            value.isEmpty ? Strings.fieldReq : null,
                        false,
                        _autoValidate,
                        false,
                        TextInputType.text,
                        null,
                        null,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Address line 2",
                        style: normalFont(MColors.textGrey, null),
                      ),
                      SizedBox(height: 5.0),
                      primaryTextField(
                        null,
                        addressList.isEmpty ? "" : address.addressLine2,
                        "",
                        (val) => _addressLine2 = val,
                        true,
                        (String value) =>
                            value.isEmpty ? Strings.fieldReq : null,
                        false,
                        _autoValidate,
                        false,
                        TextInputType.text,
                        null,
                        null,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "City",
                              style: normalFont(MColors.textGrey, null),
                            ),
                            SizedBox(height: 5.0),
                            primaryTextField(
                              null,
                              addressList.isEmpty ? "" : address.city,
                              "",
                              (val) => _city = val,
                              true,
                              (String value) =>
                                  value.isEmpty ? Strings.fieldReq : null,
                              false,
                              _autoValidate,
                              false,
                              TextInputType.text,
                              null,
                              null,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.0),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Zipcode",
                                style: normalFont(MColors.textGrey, null),
                              ),
                              SizedBox(height: 5.0),
                              primaryTextField(
                                null,
                                addressList.isEmpty ? "" : address.zipcode,
                                "",
                                (val) => _zipcode = val,
                                true,
                                (String value) =>
                                    value.isEmpty ? Strings.fieldReq : null,
                                false,
                                _autoValidate,
                                false,
                                TextInputType.numberWithOptions(),
                                null,
                                null,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "State",
                        style: normalFont(MColors.textGrey, null),
                      ),
                      SizedBox(height: 5.0),
                      primaryTextField(
                        null,
                        addressList.isEmpty ? "" : address.state,
                        "",
                        (val) => _state = val,
                        true,
                        (String value) =>
                            value.isEmpty ? Strings.fieldReq : null,
                        false,
                        _autoValidate,
                        false,
                        TextInputType.text,
                        null,
                        null,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  primaryButtonPurple(
                    Text("Save address",
                        style: normalFont(MColors.primaryWhite, 16.0)),
                    () {
                      final form = formKey.currentState;
                      if (!form.validate()) {
                        setState(() {
                          _autoValidate =
                              true; // Start validating on every change.
                        });
                        showSimpleSnack(
                          'Please fix the errors',
                          Icons.error_outline,
                          Colors.redAccent,
                          scaffoldKey,
                        );
                      } else {
                        form.save();
                        addressList.isEmpty
                            ? storeNewAddress(
                                _fullLegalName,
                                _addressLine1,
                                _addressLine2,
                                _city,
                                _zipcode,
                                _state,
                              )
                            : updateAddress(
                                _fullLegalName,
                                _addressLine1,
                                _addressLine2,
                                _city,
                                _zipcode,
                                _state,
                              );
                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: warningWidget(),
    );
  }
}
