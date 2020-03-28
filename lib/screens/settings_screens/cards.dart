import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  String _error;
  bool _autoValidate = false;
  var _state = 0;
  bool _isButtonDisabled = false;

  void animateButton() {
    setState(() {
      _state = 1;
      _isButtonDisabled = true;
    });
  }

  void _submit() async {
    // final form = formKey.currentState;

    // try {
    //   // final auth = Provider.of(context).auth;
    //   if (form.validate()) {
    //     form.save();
    //     setState(() {
    //       if (_state == 0) {
    //         animateButton();
    //       }
    //     });
    // String uid = await auth.signInWithEmailAndPassword(_email, _password);
    // print("Signed in with $uid");
    // Navigator.of(context).pop();
    // Navigator.of(context).pushReplacementNamed("/home");
    //   } else {
    //     setState(() {
    //       _autoValidate = true;
    //     });
    //   }
    // } catch (e) {
    //   setState(() {
    //     _error = e.message;
    //     _state = 0;
    //     _isButtonDisabled = false;
    //   });

    //   print(e);
    // }
  }

  Widget buildAddCardButton() {
    if (_state == 0) {
      return Text(
        "Add Card",
        style: GoogleFonts.montserrat(
            color: MColors.primaryWhite,
            fontSize: 16.0,
            fontWeight: FontWeight.bold),
      );
    } else if (_state == 1) {
      return CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(MColors.primaryWhite),
      );
    } else {
      return null;
    }
  }

  Widget addCardButton() {
    if (_isButtonDisabled == true) {
      return SizedBox(
        width: double.infinity,
        height: 60.0,
        child: RawMaterialButton(
          elevation: 0.0,
          hoverElevation: 0.0,
          focusElevation: 0.0,
          highlightElevation: 0.0,
          fillColor: MColors.primaryPurple,
          onPressed: null,
          child: buildAddCardButton(),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: RawMaterialButton(
          elevation: 0.0,
          hoverElevation: 0.0,
          focusElevation: 0.0,
          highlightElevation: 0.0,
          fillColor: MColors.primaryPurple,
          onPressed: _isButtonDisabled ? null : _submit,
          child: buildAddCardButton(),
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Navigator.of(context).pushReplacementNamed("/BottomNav");
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
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // _submit();
            },
            child: Text(
              "Add",
              style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  color: Colors.purple,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                "Add a new card to start making easy payments",
                style: GoogleFonts.montserrat(
                  fontSize: 14.0,
                  color: MColors.textGrey,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              addCardButton(),
            ],
          ),
        ),
      ),
    );
  }
}
