import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/carousel_data.dart';
import 'package:mollet/model/data/similarProducts_data.dart';
import 'package:mollet/utils/colors.dart';
import 'package:provider/provider.dart';

class SimilarProductsWidget extends StatelessWidget {
  const SimilarProductsWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          return Provider<SimilarProducts>(
            create: (context) => SimilarProducts(),
            child: Container(
              child: Consumer<SimilarProducts>(
                builder: (context, sim, child) => Column(
                  children: <Widget>[
                    Container(
                      height: 170,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          sim.images[i],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          sim.name[i],
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            color: MColors.textDark,
                            fontWeight: FontWeight.w500,
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
                        child: Text(
                          "\$${sim.price[i]}",
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
