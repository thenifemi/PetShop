import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'model/notifiers/bannerAd_notifier.dart';
import 'model/notifiers/brands_notifier.dart';
import 'model/notifiers/cart_notifier.dart';
import 'model/notifiers/notifications_notifier.dart';
import 'model/notifiers/orders_notifier.dart';
import 'model/notifiers/products_notifier.dart';
import 'model/notifiers/userData_notifier.dart';
import 'model/services/auth_service.dart';
import 'screens/getstarted_screens/intro_screen.dart';
import 'screens/getstarted_screens/splash_screen.dart';
import 'utils/colors.dart';
import 'widgets/provider.dart';
import 'widgets/tabsLayout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return exit(0);
        }

        // Once complete
        if (snapshot.connectionState == ConnectionState.done) {
          return MyProvider(
            auth: AuthService(),
            child: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness: Brightness.dark,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
              child: HomeController(),
            ),
          );
        }
        return SplashScreen();
      },
    );
  }
}

class HomeController extends StatefulWidget {
  const HomeController({Key key}) : super(key: key);

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = MyProvider.of(context).auth;

    return StreamBuilder(
        stream: auth.onAuthStateChanged,
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final bool signedIn = snapshot.hasData;
            return MaterialApp(
              title: "Pet Shop",
              theme: ThemeData(
                accentColor: MColors.primaryPurple,
                primaryColor: MColors.primaryPurple,
              ),
              debugShowCheckedModeBanner: false,
              home: signedIn
                  ? MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => ProductsNotifier(),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => BrandsNotifier(),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => CartNotifier(),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => UserDataProfileNotifier(),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => UserDataAddressNotifier(),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => OrderListNotifier(),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => NotificationsNotifier(),
                        ),
                        ChangeNotifierProvider(
                          create: (context) => BannerAdNotifier(),
                        ),
                      ],
                      child: TabsLayout(),
                    )
                  : IntroScreen(),
            );
          }
          return SplashScreen();
        });
  }
}
