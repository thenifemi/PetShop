const functions = require("firebase-functions");
const functions = require("firebase-admin");
const { admin } = require("firebase-admin/lib/database");

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
      .then((snapshots) => {
        var token;

        snapshots.empty
          ? console.log("No Devices")
          : (token = snapshots.data().token);

        var payload = { 
            "notifications" :{
                "title" : "order" + msgData.orderID
            }
        }
      });
  });
