import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const sendToDevice = functions.firestore
  .document("userOrder/{userOrderId}/orderItems/{orderItemsdId}")
  .onCreate(async (snapshot) => {
    const order = snapshot.data();

    const orderSnapshot = await db
      .collection("userData")
      .doc(order.userOrderId)
      .collection("tokens")
      .get();
      
    const tokens = orderSnapshot.docs.map((snap) => snap.id);

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: "Yay!! we've placed your order",
        body:
          "Your order has been placed and Pet Shop will take care of it for you.",
        icon: "assets/images/footprint.png",
        clickAction: "FLUTTER_NOTIFICATION_CLICK",
      },
    };
    return fcm.sendToDevice(tokens, payload);
  });
