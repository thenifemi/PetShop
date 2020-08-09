const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

var msgData;

exports.orderTrigger = functions.firestore
  .document("userOrder/{userOrderId}/orders/{ordersId}")
  .onCreate((snapshot) => {
    msgData = snapshot.data;
    var uEmail = this.orderTrigger.userOrderId;

    admin
      .firestore()
      .collection("userData")
      .doc(uEmail)

      .collection("tokens")
      .get()
      .then((snapshots) => {
        var token;

        token = snapshots.data().token;

        var payload = {
          notification: {
            title: "order" + msgData.orderID,
            body:
              "Woof! Your order is " +
              msgData.orderStatus +
              ". Pet shop will handle it for you.",
            sound: "default",
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
          },
          data: {
            sendername: "Pet Shop",
            message: "Order placed",
          },
        };

        return admin.messaging().sendToDevice(token, payload);
      });
  });
