class NotificationMessage {
  String senderAvatar;
  String senderName;
  String sentTime;
  String notificationTitle;
  String notificationBody;

  NotificationMessage.fromMap(Map<String, dynamic> data) {
    senderAvatar = data["senderAvatar"];
    senderName = data["senderName"];
    sentTime = data["sentTime"];
    notificationTitle = data["notificationTitle"];
    notificationBody = data["notificationBody"];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderAvatar': senderAvatar,
      'senderName': senderName,
      'sentTime': sentTime,
      'notificationTitle': notificationTitle,
      'notificationBody': notificationBody,
    };
  }
}
