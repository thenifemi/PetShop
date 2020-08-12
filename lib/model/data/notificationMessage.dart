import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationMessage {
  String senderAvatar;
  String senderName;
  Timestamp sentTime;
  String notificationTitle;
  String notificationBody;

  NotificationMessage.fromMap(Map<String, dynamic> data) {}
}
