import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mollet/model/services/auth_service.dart';

final db = Firestore.instance;

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

mockNotifications() async {
  String senderAvatar = "assets/images/footprint.png";
  String senderName = "Pet Shop Team";
  String sentTime = "11 Aug, 2020";
  String notificationTitle = "Order placed";
  String notificationBody =
      "Woof! Your order has been recieved by the Pet Shop, We will process everything for you. Sit back and relax. woof!";
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("notifications")
      .document(uEmail)
      .collection("message")
      .document()
      .setData({
    'senderAvatar': senderAvatar,
    'senderName': senderName,
    'sentTime': sentTime,
    'notificationTitle': notificationTitle,
    'notificationBody': notificationBody,
    'notID': "",
    'isRead': "false"
  });
}
