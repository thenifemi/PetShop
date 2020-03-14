import 'package:flutter/material.dart';
import 'package:mollet/model/services/auth_service.dart';
import 'package:mollet/screens/getstarted_screens/intro_screen.dart';
import 'package:mollet/screens/home_screens/home.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';
import 'package:mollet/screens/register_screens/registration_screen.dart';
import 'package:mollet/screens/register_screens/verification_screen.dart';
import 'package:flutter/services.dart';
import 'package:mollet/widgets/provider.dart';

// import 'model/services/provider.dart';

void main() => runApp(MyApp());

final routes = {
  '/Registration': (BuildContext context) => RegistrationScreen(),
  '/Homescreen': (BuildContext context) => HomeScreen(),
  '/Verification': (BuildContext context) => VerificationScreen(),
  '/Login': (BuildContext context) => LoginScreen(),
  // '/': (BuildContext context) => IntroScreen(),
  '/home': (BuildContext context) => HomeController(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return Provider(
      auth: AuthService(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "mollet",
        routes: routes,
        home: HomeController(),
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = Provider.of(context).auth;
    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool signedIn = snapshot.hasData;
            return signedIn ? HomeScreen() : IntroScreen();
          }
          return CircularProgressIndicator();
        });
  }
}
