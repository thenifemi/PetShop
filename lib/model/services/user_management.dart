// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class UserManagement {
  FirebaseUser user;
  storeNewUser(user, context) {
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
    }).then((val) {
      Navigator.of(context).pushReplacementNamed("/Homescreen");
    }).catchError((e) {
      print(e);
    });
  }
}
