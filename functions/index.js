const functions = require("firebase-functions");
const functions = require("firebase-admin");
const { admin } = require("firebase-admin/lib/database");

admin.initializeApp(functions.config().firebase);

var msgData;

exports.orderTrigger = functions.firestore.document(
  "userOrder/{userOrderId}/orders/{ordersId}"
).onCreate((snapshot, context) => msgData = snapshot.data);
