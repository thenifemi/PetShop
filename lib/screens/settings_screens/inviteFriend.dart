import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/utils/colors.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class InviteFriendScreen extends StatefulWidget {
  @override
  _InviteFriendScreenState createState() => _InviteFriendScreenState();
}

class _InviteFriendScreenState extends State<InviteFriendScreen> {
  var _state = 0;
  bool _isButtonDisabled = false;

  Widget buildInviteButton() {
    if (_state == 0) {
      return Text(
        "Invite a friend",
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

  Widget inviteButton() {
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
          child: buildInviteButton(),
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
          onPressed: () {
            WcFlutterShare.share(
                sharePopupTitle: 'Pet Mollet',
                subject: 'Hi!',
                text:
                    'Hi, I use PetMollet to care for my pets fast and easy, Download it here at https://github.com/thenifemi/PetShop and for every download, a dog gets a treat.',
                mimeType: 'text/plain');
          },
          child: buildInviteButton(),
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
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Invite A Friend",
          style: GoogleFonts.montserrat(
              fontSize: 20.0,
              color: MColors.primaryPurple,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/images/pets.svg",
                height: 150,
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Invite A Friend",
                style: GoogleFonts.montserrat(
                    fontSize: 25.0,
                    color: MColors.primaryPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                "When you invite a friend, a dog gets a treat.",
                style: GoogleFonts.montserrat(
                  fontSize: 16.0,
                  color: MColors.textGrey,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              inviteButton(),
            ],
          ),
        ),
      ),
    );
  }
}
