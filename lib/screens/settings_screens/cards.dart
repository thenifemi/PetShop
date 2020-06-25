import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/screens/tab_screens/checkout_screens/addPaymentMethod.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/dialogsAndSnackBars.dart';
import 'package:provider/provider.dart';

class Cards1 extends StatelessWidget {
  const Cards1({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDataCardNotifier>(
      create: (context) => UserDataCardNotifier(),
      child: Cards(),
    );
  }
}

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  Future cardFuture;

  @override
  void initState() {
    UserDataCardNotifier cardNotifier =
        Provider.of<UserDataCardNotifier>(context, listen: false);
    cardFuture = getCard(cardNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDataCardNotifier cardNotifier =
        Provider.of<UserDataCardNotifier>(context);
    var cardList = cardNotifier.userDataCardList;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MColors.primaryWhiteSmoke,
      appBar: AppBar(
        elevation: 0.0,
        brightness: Brightness.light,
        backgroundColor: MColors.primaryWhite,
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
          "Cards",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            child: FutureBuilder(
              future: cardFuture,
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
                    return cardList.isEmpty ? noCard() : savedPaymentMethod();
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
        ],
      ),
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showUpdated(String value) {
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
              child: Text("Your $value has been added"),
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

  Widget savedPaymentMethod() {
    UserDataCardNotifier cardNotifier =
        Provider.of<UserDataCardNotifier>(context);
    var cardList = cardNotifier.userDataCardList;
    var card = cardList.first;

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
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: SvgPicture.asset(
                  "assets/images/icons/Wallet.svg",
                  color: MColors.primaryPurple,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    "Payment method",
                    style: GoogleFonts.montserrat(
                      fontSize: 14.0,
                      color: MColors.textGrey,
                    ),
                  ),
                ),
              ),
              Container(
                width: 60.0,
                height: 25.0,
                child: RawMaterialButton(
                  onPressed: () async {
                    UserDataCardNotifier cardNotifier =
                        Provider.of<UserDataCardNotifier>(context,
                            listen: false);

                    var navigationResult = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AddNewCard(card, cardList),
                      ),
                    );
                    if (navigationResult == true) {
                      setState(() {
                        getCard(cardNotifier);
                      });
                      showSimpleSnack(
                        "Card has been updated",
                        Icons.check_circle_outline,
                        Colors.green,
                        _scaffoldKey,
                      );
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
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    card.cardHolder,
                    style: GoogleFonts.montserrat(
                      fontSize: 16.0,
                      color: MColors.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "**** **** **** " +
                            card.cardNumber
                                .substring(card.cardNumber.length - 4),
                        style: GoogleFonts.montserrat(
                          fontSize: 16.0,
                          color: MColors.textGrey,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      child: SvgPicture.asset(
                        "assets/images/mastercard.svg",
                        height: 30.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget noCard() {
    UserDataCardNotifier cardNotifier =
        Provider.of<UserDataCardNotifier>(context);
    var cardList = cardNotifier.userDataCardList;
    var card = cardList.first;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              "assets/images/creditcard.svg",
              height: 150,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              "No card is attached to this account",
              style: GoogleFonts.montserrat(
                fontSize: 16.0,
                color: MColors.primaryPurple,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Text(
                "Add a new card to start making quick and easy payments",
                style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: MColors.textGrey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 60.0,
              child: RawMaterialButton(
                elevation: 0.0,
                hoverElevation: 0.0,
                focusElevation: 0.0,
                highlightElevation: 0.0,
                fillColor: MColors.primaryPurple,
                onPressed: () async {
                  UserDataCardNotifier cardNotifier =
                      Provider.of<UserDataCardNotifier>(context, listen: false);

                  var navigationResult = await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddNewCard(card, cardList),
                    ),
                  );
                  if (navigationResult == true) {
                    setState(() {
                      getCard(cardNotifier);
                    });
                    showSimpleSnack(
                      "Card has been updated",
                      Icons.check_circle_outline,
                      Colors.green,
                      _scaffoldKey,
                    );
                  }
                },
                child: Text(
                  "Add Card",
                  style: GoogleFonts.montserrat(
                      color: MColors.primaryWhite,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
