import 'package:flutter/material.dart';
import 'package:mollet/screens/getstarted_screens/intro_screen.dart';
import 'package:mollet/screens/getstarted_screens/welcome_screen.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';
import 'package:mollet/screens/register_screens/registration_screen.dart';
import 'package:mollet/screens/register_screens/setFingerprint_screen.dart';
import 'package:mollet/screens/register_screens/setPassword_screen.dart';
import 'package:mollet/screens/register_screens/verification_screen.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

final routes = {
  '/Welcome': (BuildContext context) => WelcomeScreen(),
  '/Registration': (BuildContext context) => RegistrationScreen(),
  '/Verification': (BuildContext context) => VerificationScreen(),
  '/SetPassword': (BuildContext context) => SetPasswordScreen(),
  '/SetFingerprint': (BuildContext context) => SetFingerprintScreen(),
  '/Login': (BuildContext context) => LoginScreen(),
  '/': (BuildContext context) => IntroScreen(),
  '/home': (BuildContext context) => IntroScreen(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "mollet",
      routes: routes,
    );
  }
}
