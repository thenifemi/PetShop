import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';

class EnterAddress extends StatefulWidget {
  @override
  _EnterAddressState createState() => _EnterAddressState();
}

class _EnterAddressState extends State<EnterAddress> {
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
          style: boldFont(MColors.primaryPurple, 18.0),
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
                  Container(
                    child: primaryTextField(
                      null,
                      null,
                      "Search for your address",
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
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Center(
                    child: Text(
                      "Or",
                      style: boldFont(MColors.textGrey, 14.0),
                    ),
                  ),
                  SizedBox(height: 10.0),
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
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
