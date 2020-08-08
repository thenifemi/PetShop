import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

Future initialise() async {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Platform.isIOS
      ? _fcm.requestNotificationPermissions(IosNotificationSettings())
      : _fcm.configure(
          onMessage: (Map<String, dynamic> message) async {
            print("onMessage $message");
          },
          onResume: (Map<String, dynamic> message) async {
            print("onResume $message");
          },
          onLaunch: (Map<String, dynamic> message) async {
            print("onLaunch-= $message");
          },
        );
}
