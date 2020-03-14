// import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserManagement {
  storeNewUser(user, _name, context) {
    var userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = _name;
    print(user.email);
    print(userUpdateInfo.displayName);
    Firestore.instance.collection('/users').add({
      'email': user.email,
      'uid': user.uid,
      'name': userUpdateInfo.displayName,
    }).catchError((e) {
      print(e);
    });
  }
}
