"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sendToDevice = void 0;
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();
const db = admin.firestore();
const fcm = admin.messaging();
exports.sendToDevice = functions.firestore
    .document("userOrder/{userOrderId}/orders/{ordersId}")
    .onCreate(async (snapshot) => {
    const order = snapshot.data();
    const orderSnapshot = await db
        .collection("userData")
        .doc(order.userOrderId)
        .collection("tokens")
        .get();
    const tokens = orderSnapshot.docs.map((snap) => snap.id);
    const payload = {
        notification: {
            title: "Yay!! we've placed your order",
            body: "Your order has been placed and Pet Shop will take care of it for you.",
            icon: "assets/images/footprint.png",
            clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
    };
    return fcm.sendToDevice(tokens, payload);
});
//# sourceMappingURL=index.js.map