import 'package:flutter/foundation.dart';
import 'package:petShop/model/data/notificationMessage.dart';

class NotificationsNotifier with ChangeNotifier {
  List<NotificationMessage> _notificationMessageList = [];

  List<NotificationMessage> get notificationMessageList =>
      _notificationMessageList;

  set notificationMessageList(
      List<NotificationMessage> notificatioMessageList) {
    _notificationMessageList = notificatioMessageList;
    notifyListeners();
  }
}
