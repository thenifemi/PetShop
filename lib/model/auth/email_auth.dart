import 'package:firebase_auth/firebase_auth.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:flutter/widgets.dart';

//REGISTER (CONTINUED IN user_management.dart)
void performRegistration(_email, _password, _name, context) {
  FirebaseAuth.instance
      .createUserWithEmailAndPassword(
    email: _email,
    password: _password,
  )
      .then((signedInUser) {
    // FirebaseUser user;
    var userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = _name;
    UserManagement().storeNewUser(signedInUser.user, _name, context);
    Navigator.of(context).pushReplacementNamed("/Homescreen");
  }).catchError((e) {
    print(e);
  });
}

//LOGIN
void performLogin(_email, _password, context) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(
    email: _email,
    password: _password,
  )
      .then((user) {
    Navigator.of(context).pushReplacementNamed("/Homescreen");
  }).catchError((e) {
    print(e);
  });
}

//LOGOUT
void performLogout(context) {
  FirebaseAuth.instance.signOut().then((val) {
    Navigator.of(context).pushReplacementNamed("/Login");
  }).catchError((e) {
    print(e);
  });
}
