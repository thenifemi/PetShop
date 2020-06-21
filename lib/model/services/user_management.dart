import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/auth_service.dart';

//Storing new user data
storeNewUser(_name, _phone, _email) async {
  final db = Firestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  var userUpdateInfo = new UserUpdateInfo();
  userUpdateInfo.displayName = _name;
  print(userUpdateInfo.displayName);

  await db
      .collection("userData")
      .document(uEmail)
      .collection("profile")
      .document(uEmail)
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
  final uEmail = await AuthService().getCurrentEmail();

  CollectionReference profileRef =
      db.collection("userData").document(uEmail).collection("profile");
  await profileRef.document(uEmail).updateData(
    {'name': _name, 'phone': _phone},
  );
}

//Updating User password
// updatePassword(password) async {
//   final user = await AuthService().getCurrentUser();
//   user.updatePassword(password).then((_) {
//     print("Password changed successfully");
//   }).catchError((e) {
//     print("ERROR ====>>>" + e);
//   });
// }

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
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userData")
      .document(uEmail)
      .collection("address")
      .document(uEmail)
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

//get users address
getAddress(UserDataAddressNotifier addressNotifier) async {
  final uEmail = await AuthService().getCurrentEmail();

  QuerySnapshot snapshot = await Firestore.instance
      .collection("userData")
      .document(uEmail)
      .collection("address")
      .getDocuments();

  List<UserDataAddress> _userDataAddressList = [];

  snapshot.documents.forEach((document) {
    print(document.data);
    UserDataAddress userDataAddress = UserDataAddress.fromMap(document.data);
    _userDataAddressList.add(userDataAddress);
  });

  addressNotifier.userDataAddressList = _userDataAddressList;
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
  final uEmail = await AuthService().getCurrentEmail();
  CollectionReference addressRef =
      db.collection("userData").document(uEmail).collection("address");
  await addressRef.document(uEmail).updateData(
    {
      'fullLegalName': fullLegalName,
      'addressLine1': addressLine1,
      'addressLine2': addressLine2,
      'city': city,
      'zipcode': zip,
      'state': state,
    },
  );
}

//Adding new address
storeNewCard(
  cardHolder,
  cardNumber,
  validThrough,
  securityCode,
) async {
  final db = Firestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userData")
      .document(uEmail)
      .collection("card")
      .document(uEmail)
      .setData({
    'cardHolder': cardHolder,
    'cardNumber': cardNumber,
    'valdThrough': validThrough,
    'securityCode': securityCode,
  }).catchError((e) {
    print(e);
  });
}
