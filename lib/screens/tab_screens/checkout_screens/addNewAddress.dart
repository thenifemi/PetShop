import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/utils/colors.dart';

class AddNewAddress extends StatefulWidget {
  AddNewAddress({Key key}) : super(key: key);

  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  String _fullLegalName;
  String _addressLine1;
  String _addressLine2;
  String _city;
  String _zipcode;
  String _state;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  // void showSaveAddressDialog() async {
  //   await showCupertinoDialog(
  //       context: context,
  //       builder: (context) {
  //         return CupertinoAlertDialog(
  //           content: Text(
  //             "Sure you want to save this address?",
  //             style: GoogleFonts.montserrat(),
  //           ),
  //           actions: <Widget>[
  //             CupertinoDialogAction(
  //               onPressed: () async {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text(
  //                 "Cancel",
  //                 style: GoogleFonts.montserrat(
  //                   color: Colors.redAccent,
  //                 ),
  //               ),
  //             ),
  //             CupertinoDialogAction(
  //               onPressed: () {},
  //               isDefaultAction: true,
  //               child: Text(
  //                 "Yes",
  //                 style: GoogleFonts.montserrat(),
  //               ),
  //             ),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
          "Add address",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Full legal name",
                        style: GoogleFonts.montserrat(color: MColors.textGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        onSaved: (val) => _fullLegalName = val,
                        decoration: InputDecoration(
                          labelText: "",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 25.0),
                          fillColor: MColors.primaryWhite,
                          hasFloatingPlaceholder: false,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: MColors.textGrey,
                              width: 0.50,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: MColors.primaryPurple,
                              width: 1.0,
                            ),
                          ),
                        ),
                        style: GoogleFonts.montserrat(
                            fontSize: 17.0, color: MColors.textDark),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Address line 1",
                        style: GoogleFonts.montserrat(color: MColors.textGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        onSaved: (val) => _addressLine1 = val,
                        decoration: InputDecoration(
                          labelText: "",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 25.0),
                          fillColor: MColors.primaryWhite,
                          hasFloatingPlaceholder: false,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: MColors.textGrey,
                              width: 0.50,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: MColors.primaryPurple,
                              width: 1.0,
                            ),
                          ),
                        ),
                        style: GoogleFonts.montserrat(
                            fontSize: 17.0, color: MColors.textDark),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Address line 2",
                        style: GoogleFonts.montserrat(color: MColors.textGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        onSaved: (val) => _addressLine2 = val,
                        decoration: InputDecoration(
                          labelText: "",
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 25.0),
                          fillColor: MColors.primaryWhite,
                          hasFloatingPlaceholder: false,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: MColors.textGrey,
                              width: 0.50,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: MColors.primaryPurple,
                              width: 1.0,
                            ),
                          ),
                        ),
                        style: GoogleFonts.montserrat(
                            fontSize: 17.0, color: MColors.textDark),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "City",
                              style: GoogleFonts.montserrat(
                                  color: MColors.textGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              onSaved: (val) => _city = val,
                              decoration: InputDecoration(
                                labelText: "",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25.0),
                                fillColor: MColors.primaryWhite,
                                hasFloatingPlaceholder: false,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: MColors.textGrey,
                                    width: 0.50,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: Colors.red,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide(
                                    color: MColors.primaryPurple,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              style: GoogleFonts.montserrat(
                                  fontSize: 17.0, color: MColors.textDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                "Zip code",
                                style: GoogleFonts.montserrat(
                                    color: MColors.textGrey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: TextFormField(
                                onSaved: (val) => _zipcode = val,
                                keyboardType: TextInputType.numberWithOptions(),
                                decoration: InputDecoration(
                                  labelText: "",
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 25.0),
                                  fillColor: MColors.primaryWhite,
                                  hasFloatingPlaceholder: false,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: MColors.textGrey,
                                      width: 0.50,
                                    ),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: Colors.red,
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(
                                      color: MColors.primaryPurple,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                style: GoogleFonts.montserrat(
                                    fontSize: 17.0, color: MColors.textDark),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "State",
                        style: GoogleFonts.montserrat(color: MColors.textGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        onSaved: (val) => _state = val,
                        decoration: InputDecoration(
                          labelText: "",
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 25.0),
                          fillColor: MColors.primaryWhite,
                          hasFloatingPlaceholder: false,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: MColors.textGrey,
                              width: 0.50,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: MColors.primaryPurple,
                              width: 1.0,
                            ),
                          ),
                        ),
                        style: GoogleFonts.montserrat(
                            fontSize: 17.0, color: MColors.textDark),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 50.0,
                  width: MediaQuery.of(context).size.width,
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
                    onPressed: () {
                      final form = formKey.currentState;
                      form.save();
                      storeNewAddress(
                        _fullLegalName,
                        _addressLine1,
                        _addressLine2,
                        _city,
                        _zipcode,
                        _state,
                      );
                      Navigator.pop(context, true);
                    },
                    child: Center(
                      child: Text(
                        "Save address",
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          color: MColors.textDark,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: Icon(
                          Icons.error_outline,
                          color: Colors.redAccent,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            "PLEASE NOTE -  This is a side project by Nifemi. Please do not enter a real address. Thank you!",
                            style: GoogleFonts.montserrat(
                              color: Colors.redAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // height: 80.0,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: MColors.primaryWhiteSmoke,
                    border:
                        Border.all(width: 1.0, color: MColors.primaryPurple),
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
