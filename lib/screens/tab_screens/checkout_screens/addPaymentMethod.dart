import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/utils/cardUtils/payment_card.dart';
import 'package:mollet/utils/cardUtils/input_formatter.dart';
import 'package:mollet/utils/cardUtils/cardStrings.dart';

class AddNewCard extends StatefulWidget {
  final UserDataCard card;
  final List<UserDataCard> cardList;

  AddNewCard(this.card, this.cardList);

  @override
  _AddNewCardState createState() => _AddNewCardState(card, cardList);
}

class _AddNewCardState extends State<AddNewCard> {
  final UserDataCard card;
  final List<UserDataCard> cardList;

  _AddNewCardState(this.card, this.cardList);

  String cardHolder;
  String cardNumber;
  String validThrough;
  String securityCode;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  var numberController = new TextEditingController();
  var _paymentCard = PaymentCard();
  var _autoValidate = false;

  var _card = PaymentCard();

  @override
  void initState() {
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
    super.initState();
  }

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
          "Add Card",
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
          autovalidate: _autoValidate,
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
                        "Card Holder",
                        style: GoogleFonts.montserrat(color: MColors.textGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        initialValue: cardList.isEmpty ? "" : card.cardHolder,
                        onSaved: (val) => cardHolder = val,
                        validator: (String value) =>
                            value.isEmpty ? Strings.fieldReq : null,
                        decoration: InputDecoration(
                          labelText: "",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 25.0),
                          fillColor: MColors.primaryWhite,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                        "Card Number",
                        style: GoogleFonts.montserrat(color: MColors.textGrey),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        initialValue: cardList.isEmpty ? null : null,
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(19),
                          CardNumberInputFormatter(),
                        ],
                        onSaved: (val) => cardNumber = val,
                        validator: CardUtils.validateCardNum,
                        decoration: InputDecoration(
                          suffixIcon: CardUtils.getCardIcon(_paymentCard.type),
                          labelText: "",
                          contentPadding:
                              new EdgeInsets.symmetric(horizontal: 25.0),
                          fillColor: MColors.primaryWhite,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Valid through",
                              style: GoogleFonts.montserrat(
                                  color: MColors.textGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: CardUtils.validateDate,
                              initialValue: cardList.isEmpty ? null : null,
                              onSaved: (val) => validThrough = val,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                                CardMonthInputFormatter(),
                              ],
                              decoration: InputDecoration(
                                labelText: "",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25.0),
                                fillColor: MColors.primaryWhite,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              "Security Code",
                              style: GoogleFonts.montserrat(
                                  color: MColors.textGrey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: TextFormField(
                              initialValue: cardList.isEmpty ? null : null,
                              onSaved: (val) => securityCode = val,
                              inputFormatters: <TextInputFormatter>[
                                WhitelistingTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              keyboardType: TextInputType.number,
                              validator: CardUtils.validateCVV,
                              decoration: InputDecoration(
                                labelText: "",
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 25.0),
                                fillColor: MColors.primaryWhite,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                      _validateInputs();
                    },
                    child: Center(
                      child: Text(
                        "Save Card",
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
                            "PLEASE NOTE -  This is a side project by Nifemi. Please do not enter real card info. Thank you!",
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      this._paymentCard.type = cardType;
    });
  }

  void _validateInputs() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      setState(() {
        _autoValidate = true; // Start validating on every change.
      });
      _showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      // Encrypt and send send payment details to payment gateway

      cardList.isEmpty
          ? storeNewCard(
              cardHolder,
              cardNumber,
              validThrough,
              securityCode,
            )
          : updateCard(
              cardHolder,
              cardNumber,
              validThrough,
              securityCode,
            );
      Navigator.pop(context, true);
    }
  }

  void _showInSnackBar(String value) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: 1300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        content: Row(
          children: <Widget>[
            Expanded(
              child: Text(value),
            ),
            Icon(
              Icons.error_outline,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
