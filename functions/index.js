const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp(functions.config().firebase);

var msgData;

var uEmail = await AuthService().getCurrentEmail();

exports.orderTrigger = functions.firestore
  .document("userOrder/{userOrderId}/orders/{ordersId}")
  .onCreate((snapshot, context) => {
    msgData = snapshot.data;

    admin
      .firestore()
      .collection("userData")
      .document(uEmail)
      .collection("tokens")
      .get()
      .then(async (snapshots) => {
        var token;

        snapshots.empty
          ? console.log("No Devices")
          : (token = snapshots.data().token);

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

        try {
          const response = await admin.messaging().sendToDevice(token, payload);
          console.log("Sent!" + response);
        } catch (e) {
          console.log(e);
        }
      });
  });
