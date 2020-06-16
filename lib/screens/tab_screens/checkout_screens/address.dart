import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AddressContainer(),
    );
  }
}

class AddressContainer extends StatefulWidget {
  @override
  _AddressContainerState createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  @override
  Widget build(BuildContext context) {
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
          "Address",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Container(
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
                          "No saved addresses",
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
                  ],
                ),
              ),
              Container(
                color: Colors.purple,
                height: MediaQuery.of(context).size.height / 4,
                margin: EdgeInsets.symmetric(vertical: 10.0),
              ),
              Container(
                color: Colors.purple,
                height: MediaQuery.of(context).size.height / 4,
                margin: EdgeInsets.symmetric(vertical: 10.0),
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
}
