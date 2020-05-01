import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/prodModel/Products.dart';
import 'package:mollet/screens/home_screens/homeScreen_buttonPages/homeProductScreens/productDetailsScreen.dart';
import 'package:mollet/utils/colors.dart';

class SimilarProductsWidget extends StatefulWidget {
  ProdProducts prodDetails;

  UnmodifiableListView<ProdProducts> prods;

  SimilarProductsWidget({Key key, this.prods, this.prodDetails})
      : super(key: key);

  @override
  _SimilarProductsWidgetState createState() =>
      _SimilarProductsWidgetState(prods, prodDetails);
}

class _SimilarProductsWidgetState extends State<SimilarProductsWidget> {
  ProdProducts prodDetails;

  UnmodifiableListView<ProdProducts> prods;
  _SimilarProductsWidgetState(this.prods, this.prodDetails);

  @override
  Widget build(BuildContext context) {
    var sims = prods;

    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.4;
    final double itemWidth = size.width / 2;

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      height: size.height / 1.38,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: (itemWidth / itemHeight),
        mainAxisSpacing: 15.0,
        crossAxisSpacing: 15.0,
        children: List<Widget>.generate(4, (i) {
          Iterable<ProdProducts> iterable = sims
              .where((item) => item.pet == prodDetails.pet)
              .skipWhile((item) => item.productID == prodDetails.productID);

          List<ProdProducts> filteredList = iterable.toList();

          var fil = filteredList[i];

          //////////////////////

          return RawMaterialButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetails(fil, prods),
                ),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0),
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 170,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: filteredList == null
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Image.network(
                              fil.productImage,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: filteredList == null
                          ? Center(
                              child: Text("..."),
                            )
                          : Text(
                              fil.name,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                color: MColors.textDark,
                                // fontWeight: FontWeight.w400,
                                fontSize: 16.0,
                              ),
                            ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                      child: filteredList == null
                          ? Center(
                              child: Text("..."),
                            )
                          : Text(
                              "\$${fil.price}",
                              style: GoogleFonts.montserrat(
                                color: MColors.primaryPurple,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                              textAlign: TextAlign.left,
                            ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: MColors.primaryWhite,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.03),
                      offset: Offset(0, 10),
                      blurRadius: 10,
                      spreadRadius: 0),
                ],
              ),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
            ),
          );
        }),
      ),
    );
  }
}
