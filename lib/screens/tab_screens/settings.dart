import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mollet/main.dart';

import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:mollet/screens/settings_screens/cards.dart';
import 'package:mollet/screens/settings_screens/editProfile.dart';
import 'package:mollet/screens/settings_screens/inviteFriend.dart';
import 'package:mollet/screens/settings_screens/passwordSecurity.dart';
import 'package:mollet/utils/colors.dart';
import 'package:mollet/widgets/provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future profileFuture;

  @override
  void initState() {
    UserDataProfileNotifier profileNotifier =
        Provider.of<UserDataProfileNotifier>(context, listen: false);
    profileFuture = getProfile(profileNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDataProfileNotifier profileNotifier =
        Provider.of<UserDataProfileNotifier>(context);
    var user = profileNotifier.userDataProfileList.first;
    var checkUser = profileNotifier.userDataProfileList;

    return FutureBuilder(
      builder: (context, s) => Container(
        height: double.infinity,
        color: MColors.primaryWhiteSmoke,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            color: MColors.primaryWhiteSmoke,
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => EditProfile(),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/images/femaleAvatar.svg",
                                height: 90.0,
                              ),
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color: MColors.dashPurple,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Builder(
                            builder: (context) {
                              switch (s.connectionState) {
                                case ConnectionState.active:
                                  return Container(
                                    color: MColors.primaryWhiteSmoke,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.0,
                                      ),
                                    ),
                                  );
                                  break;
                                case ConnectionState.done:
                                  return user == null
                                      ? Container(
                                          color: MColors.primaryWhiteSmoke,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.0,
                                            ),
                                          ),
                                        )
                                      : Column(
                                          children: <Widget>[
                                            Text(
                                              user.name,
                                              style: GoogleFonts.montserrat(
                                                color: MColors.primaryPurple,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                right: 30.0,
                                                left: 30.0,
                                                top: 3.0,
                                              ),
                                              child: Text(
                                                user.email,
                                                style: GoogleFonts.montserrat(
                                                  color: MColors.textGrey,
                                                  fontSize: 13.0,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        );
                                  break;
                                case ConnectionState.waiting:
                                  return Container(
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
                        SizedBox(height: 5.0),
                        SizedBox(
                          width: 100,
                          height: 18.0,
                          child: RawMaterialButton(
                            elevation: 0.0,
                            hoverElevation: 0.0,
                            focusElevation: 0.0,
                            highlightElevation: 0.0,
                            fillColor: MColors.dashPurple,
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => EditProfile(),
                                ),
                              );
                            },
                            child: Text(
                              "EDIT PROFILE",
                              style: GoogleFonts.montserrat(
                                color: MColors.primaryPurple,
                                fontSize: 12.0,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Divider(
                  height: 1.0,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SecurityScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: SvgPicture.asset(
                            "assets/images/password.svg",
                            height: 20,
                            color: MColors.textGrey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Security",
                            style: GoogleFonts.montserrat(
                              color: MColors.primaryPurple,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: MColors.textGrey,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => Cards(),
                        ),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: SvgPicture.asset(
                            "assets/images/icons/Wallet.svg",
                            height: 20,
                            color: MColors.textGrey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Cards",
                            style: GoogleFonts.montserrat(
                              color: MColors.primaryPurple,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: MColors.textGrey,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => InviteFriendScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: SvgPicture.asset(
                            "assets/images/gift.svg",
                            height: 20,
                            color: MColors.textGrey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Invite a friend",
                            style: GoogleFonts.montserrat(
                              color: MColors.primaryPurple,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: MColors.textGrey,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: RawMaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: SvgPicture.asset(
                            "assets/images/help.svg",
                            height: 20,
                            color: MColors.textGrey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Help",
                            style: GoogleFonts.montserrat(
                              color: MColors.primaryPurple,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: MColors.textGrey,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: RawMaterialButton(
                    onPressed: () {},
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: SvgPicture.asset(
                            "assets/images/question.svg",
                            height: 20,
                            color: MColors.textGrey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "FAQs",
                            style: GoogleFonts.montserrat(
                              color: MColors.primaryPurple,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: MColors.textGrey,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
                SizedBox(height: 100.0),
                SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: RawMaterialButton(
                    onPressed: () {
                      _showLogOutDialog();
                    },
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: SvgPicture.asset(
                            "assets/images/logout.svg",
                            height: 20,
                            color: Colors.redAccent,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Sign out",
                            style: GoogleFonts.montserrat(
                              color: Colors.redAccent,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Version 0.0.1",
                      style: GoogleFonts.montserrat(
                        color: MColors.textGrey,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
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

  void _showLogOutDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              "Are you sure you want to sign out?",
              style: GoogleFonts.montserrat(),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.montserrat(color: MColors.textGrey),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  try {
                    AuthService auth = MyProvider.of(context).auth;
                    auth.signOut();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => MyApp(),
                      ),
                    );
                    print("Signed out.");
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  "Sign out",
                  style: GoogleFonts.montserrat(
                      color: Colors.redAccent, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          );
        });
  }
}
