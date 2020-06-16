import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

class UserManagement {
  //Storing new user data
  storeNewUser(_name, _phoneNumber, _email, context) async {
    final db = Firestore.instance;
    final uid = await AuthService().getCurrentUID();

    var userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = _name;
    print(userUpdateInfo.displayName);
    await db
        .collection("userData")
        .document(uid)
        .collection("usersName")
        .add({"name": userUpdateInfo.displayName}).catchError((e) {
      print(e);
    });
    await db
        .collection("userData")
        .document(uid)
        .collection("usersPhone")
        .add({"phone": _phoneNumber}).catchError((e) {
      print(e);
    });
    await db
        .collection("userData")
        .document(uid)
        .collection("usersEmail")
        .add({"email": _email}).catchError((e) {
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
