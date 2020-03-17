import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mollet/widgets/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Stream<QuerySnapshot> getUsersNameStreamSnapshot(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('usersName')
        .snapshots();
  }

  Stream<QuerySnapshot> getUsersEmailStreamSnapshot(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('usersEmail')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: MColors.primaryWhiteSmoke,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MColors.primaryWhiteSmoke,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: IconButton(
              icon: Icon(
                Icons.menu,
                color: MColors.primaryPurple,
                size: 35.0,
              ),
              onPressed: () {
                scaffoldKey.currentState.openDrawer();
              }),
        ),
      ),
      drawer: Drawer(
          child: Container(
        color: MColors.primaryWhiteSmoke,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? MColors.primaryPurple
                          : MColors.primaryPurple,
                  child: Text("N")),
              accountName: StreamBuilder(
                  stream: getUsersNameStreamSnapshot(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        "Human",
                        style: TextStyle(
                            fontSize: 18.0,
                            color: MColors.textGrey,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      );
                    } else {
                      return Text(
                        snapshot.data.documents[0]['name'],
                        style: TextStyle(
                            fontSize: 18.0,
                            color: MColors.textGrey,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      );
                    }
                  }),
              accountEmail: StreamBuilder(
                  stream: getUsersEmailStreamSnapshot(context),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        "Loading...",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: MColors.textGrey,
                        ),
                        textAlign: TextAlign.start,
                      );
                    } else {
                      return Text(
                        snapshot.data.documents[0]['email'],
                        style: TextStyle(
                          fontSize: 16.0,
                          color: MColors.textGrey,
                        ),
                        textAlign: TextAlign.start,
                      );
                    }
                  }),
              decoration: BoxDecoration(
                color: MColors.primaryWhiteSmoke,
              ),
            ),
            ListTile(
                title: Text("Page One"),
                trailing: Icon(Icons.arrow_upward),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            ListTile(
                title: Text("Page Two"),
                trailing: Icon(Icons.arrow_downward),
                onTap: () {
                  Navigator.of(context).pop();
                }),
            Divider(),
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      )),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(
                      "Hi ",
                      style: TextStyle(
                          fontSize: 38.0,
                          color: MColors.textDark,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    child: StreamBuilder(
                        stream: getUsersNameStreamSnapshot(context),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text(
                              "Human",
                              style: TextStyle(
                                  fontSize: 38.0,
                                  color: MColors.textDark,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            );
                          } else {
                            return Text(
                              snapshot.data.documents[0]['name'],
                              style: TextStyle(
                                  fontSize: 38.0,
                                  color: MColors.textDark,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            );
                          }
                        }),
                  ),
                  Container(
                    child: Text(
                      ",",
                      style: TextStyle(
                          fontSize: 38.0,
                          color: MColors.textDark,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(
                "What would you like to do today?",
                style: TextStyle(
                    fontSize: 30.0,
                    color: MColors.textDark,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              child: SvgPicture.asset(
                "assets/images/pets.svg",
                height: 250,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20.0, left: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
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
                        try {
                          AuthService auth = Provider.of(context).auth;
                          auth.signOut();
                          print("Signed out.");
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
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
          ],
        ),
      ),
    );
  }
}
