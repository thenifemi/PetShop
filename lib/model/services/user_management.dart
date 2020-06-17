import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/auth_service.dart';

//Storing new user data
storeNewUser(_name, _phone, _email) async {
  final db = Firestore.instance;
  final uid = await AuthService().getCurrentUID();
  final uEmail = await AuthService().getCurrentEmail();

  var userUpdateInfo = new UserUpdateInfo();
  userUpdateInfo.displayName = _name;
  print(userUpdateInfo.displayName);

  await db
      .collection("userData")
      .document(uEmail)
      .collection("profile")
      .document(uid)
      .setData({
    'name': _name,
    'phone': _phone,
    'email': _email,
  }).catchError((e) {
    print(e);
  });
}

//Getting User profile
getProfile(UserDataProfileNotifier profileNotifier) async {
  // final uid = await AuthService().getCurrentUID();
  final uEmail = await AuthService().getCurrentEmail();

  QuerySnapshot snapshot = await Firestore.instance
      .collection("userData")
      .document(uEmail)
      .collection("profile")
      .getDocuments();

  List<UserDataProfile> _userDataProfileList = [];

  snapshot.documents.forEach((document) {
    print(document.data);
    UserDataProfile userDataProfile = UserDataProfile.fromMap(document.data);
    _userDataProfileList.add(userDataProfile);
  });

  profileNotifier.userDataProfileList = _userDataProfileList;
}

//Updating User profile
updateProfile(_name, _phone) async {
  final db = Firestore.instance;
  final uid = await AuthService().getCurrentUID();
  final uEmail = await AuthService().getCurrentEmail();

  CollectionReference profileRef =
      db.collection("userData").document(uEmail).collection("profile");
  await profileRef.document(uid).updateData(
    {'name': _name, 'phone': _phone},
  );
}

//Adding new address
storeNewAddress(
  fullLegalName,
  addressLine1,
  addressLine2,
  city,
  zip,
  state,
) async {
  final db = Firestore.instance;
  // final uid = await AuthService().getCurrentUID();
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userData")
      .document(uEmail)
      .collection("address")
      .document(zip)
      .setData({
    'fullLegalName': fullLegalName,
    'addressLine1': addressLine1,
    'addressLine2': addressLine2,
    'city': city,
    'zipcode': zip,
    'state': state,
  }).catchError((e) {
    print(e);
  });
}

//Updating new address
updateAddress(
  fullLegalName,
  addressLine1,
  addressLine2,
  city,
  zip,
  state,
) async {
  final db = Firestore.instance;
  // final uid = await AuthService().getCurrentUID();
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userData")
      .document(uEmail)
      .collection("address")
      .document(zip)
      .updateData({
    'fullLegalName': fullLegalName,
    'addressLine1': addressLine1,
    'addressLine2': addressLine2,
    'city': city,
    'zipcode': zip,
    'state': state,
  }).catchError((e) {
    print(e);
  });
}
