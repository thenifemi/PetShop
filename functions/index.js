const functions = require('firebase-functions');
const admin = require('firebase-admin')

admin.initializeApp(functions.config().firebase);

var msgData;

exports.getCUser = functions.auth.use
exports.orderTrigger = functions.firestore.document
