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

// Adding new address
storeAddress(
  fullLegalName,
  addressLocation,
  addressNumber,
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
    'addressLocation': addressLocation,
    'addressNumber': addressNumber,
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
    UserDataAddress userDataAddress = UserDataAddress.fromMap(document.data);
    _userDataAddressList.add(userDataAddress);
  });

  addressNotifier.userDataAddressList = _userDataAddressList;
}

//Updating new address
updateAddress(
  fullLegalName,
  addressLocation,
  addressNumber,
) async {
  final db = Firestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  CollectionReference addressRef =
      db.collection("userData").document(uEmail).collection("address");
  await addressRef.document(uEmail).updateData(
    {
      'fullLegalName': fullLegalName,
      'addressLocation': addressLocation,
      'addressNumber': addressNumber,
    },
  );
}

//Adding new card
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
    'validThrough': validThrough,
    'securityCode': securityCode,
  }).catchError((e) {
    print(e);
  });
}

//get users card
getCard(UserDataCardNotifier cardNotifier) async {
  final uEmail = await AuthService().getCurrentEmail();

  QuerySnapshot snapshot = await Firestore.instance
      .collection("userData")
      .document(uEmail)
      .collection("card")
      .getDocuments();

  List<UserDataCard> _userDataCardList = [];

  snapshot.documents.forEach((document) {
    UserDataCard userDataCard = UserDataCard.fromMap(document.data);
    _userDataCardList.add(userDataCard);
  });

  cardNotifier.userDataCardList = _userDataCardList;
}

//Updating new card
updateCard(
  cardHolder,
  cardNumber,
  validThrough,
  securityCode,
) async {
  final db = Firestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  CollectionReference cardRef =
      db.collection("userData").document(uEmail).collection("card");
  await cardRef.document(uEmail).updateData(
    {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'validThrough': validThrough,
      'securityCode': securityCode,
    },
  );
}
