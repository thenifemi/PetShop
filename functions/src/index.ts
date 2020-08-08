import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

const sendToTopic = functions.firestore
  .document("userOrder/{userOrderId}/orderItems/{orderItemsdId}")
  .onCreate(async (snapshot) => {
    const order = snapshot.data();
  });
