import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

class UserManagement {
  //Storing new user data
  storeNewUser(profile) async {
    final db = Firestore.instance;
    final uid = await AuthService().getCurrentUID();

    var userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = profile.name;
    print(userUpdateInfo.displayName);

    await db
        .collection("userData")
        .document(uid)
        .collection("profile")
        .document(profile.email)
        .setData(profile.toMap())
        .catchError((e) {
      print(e);
    });
  }

  //adding new address
  storeNewAddress(address) async {
    final db = Firestore.instance;
    final uid = await AuthService().getCurrentUID();
    await db
        .collection("userData")
        .document(uid)
        .collection("address")
        .document(address.zipcode)
        .setData(address.toMap())
        .catchError((e) {
      print(e);
    });
  }
}
