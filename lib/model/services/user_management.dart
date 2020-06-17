import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'auth_service.dart';

class UserManagement {
  //Storing new user data
  storeNewUser(_name, _phone, _email) async {
    final db = Firestore.instance;
    final uid = await AuthService().getCurrentUID();

    var userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = _name;
    print(userUpdateInfo.displayName);

    await db
        .collection("userData")
        .document(uid)
        .collection("profile")
        .document(_email)
        .setData({
      'name': _name,
      'phone': _phone,
      'email': _email,
    }).catchError((e) {
      print(e);
    });
  }
}

getProfile(UserDataProfileNotifier profileNotifier) async {
  final uid = await AuthService().getCurrentUser();
  QuerySnapshot snapshot = await Firestore.instance
      .collection("userData")
      .document(uid)
      .collection("profile")
      .getDocuments();

  List<UserDataProfile> _userDataProfileList = [];

  snapshot.documents.forEach((document) {
    UserDataProfile userDataProfile = UserDataProfile.fromMap(document.data);
    _userDataProfileList.add(userDataProfile);
  });

  profileNotifier.userDataProfileList = _userDataProfileList;
  print("hey");
  print(profileNotifier.userDataProfileList);
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
