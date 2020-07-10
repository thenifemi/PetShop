import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/screens/tab_screens/checkout_screens/addPaymentMethod.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/allWidgets.dart';
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
          "Cards",
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
      ),
    );
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
        mainAxisAlignment: MainAxisAlignment.center,
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
                    style: normalFont(MColors.textGrey, 14.0),
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
                  child: Text("Change",
                      style: boldFont(MColors.primaryPurple, 14.0)),
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
                  child: Text(
                    card.cardHolder,
                    style: boldFont(MColors.textDark, 16.0),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        "•••• •••• •••• " +
                            card.cardNumber
                                .substring(card.cardNumber.length - 4),
                        style: normalFont(MColors.textGrey, 16.0),
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
                    style: normalFont(MColors.textGrey, 14.0),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Container(
            padding: const EdgeInsets.only(left: 25.0),
            child: Text(
              "No payment method added to this account",
              style: normalFont(MColors.textGrey, 16.0),
            ),
          ),
          SizedBox(height: 10.0),
          primaryButtonWhiteSmoke(
            Text("Add a payment method",
                style: boldFont(MColors.primaryPurple, 16.0)),
            () async {
              var navigationResult = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNewCard(null, cardList),
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
          ),
        ],
      ),
    );
  }
}
