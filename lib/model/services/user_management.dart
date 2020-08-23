import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mollet/credentials.dart';
import 'package:mollet/model/data/userData.dart';
import 'package:mollet/model/notifiers/userData_notifier.dart';
import 'package:mollet/model/services/auth_service.dart';

//Storing new user data
storeNewUser(_name, _phone, _email) async {
  final db = FirebaseFirestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  var user = FirebaseAuth.instance.currentUser.displayName;
  user = _name;
  print(user);

  await db
      .collection("userData")
      .doc(uEmail)
      .collection("profile")
      .doc(uEmail)
      .set({
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

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("userData")
      .doc(uEmail)
      .collection("profile")
      .get();

  List<UserDataProfile> _userDataProfileList = [];

  snapshot.docs.forEach((doc) {
    UserDataProfile userDataProfile = UserDataProfile.fromMap(doc.data());
    _userDataProfileList.add(userDataProfile);
  });

  profileNotifier.userDataProfileList = _userDataProfileList;
}

//Updating User profile
updateProfile(_name, _phone) async {
  final db = FirebaseFirestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  CollectionReference profileRef =
      db.collection("userData").doc(uEmail).collection("profile");
  await profileRef.doc(uEmail).update(
    {'name': _name, 'phone': _phone},
  );
}

Future updateProfilePhoto(file) async {
  final db = FirebaseFirestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  //Input the link to your own firebase storage bucket
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: FIREBASE_STORAGE_BUCKET);

  String filePath = 'userImages/$uEmail.png';

  StorageUploadTask uploadTask = _storage.ref().child(filePath).putFile(file);

  StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;

  var ref = storageTaskSnapshot.ref;
  var profilePhoto = await ref.getDownloadURL();

  print(profilePhoto);

  CollectionReference profileRef =
      db.collection("userData").doc(uEmail).collection("profile");
  await profileRef.doc(uEmail).update(
    {
      'profilePhoto': profilePhoto,
    },
  );
}

// Adding new address
storeAddress(
  fullLegalName,
  addressLocation,
  addressNumber,
) async {
  final db = FirebaseFirestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userData")
      .doc(uEmail)
      .collection("address")
      .doc(uEmail)
      .set({
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

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("userData")
      .doc(uEmail)
      .collection("address")
      .get();

  List<UserDataAddress> _userDataAddressList = [];

  snapshot.docs.forEach((doc) {
    UserDataAddress userDataAddress = UserDataAddress.fromMap(doc.data());
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
  final db = FirebaseFirestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  CollectionReference addressRef =
      db.collection("userData").doc(uEmail).collection("address");
  await addressRef.doc(uEmail).update(
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
  final db = FirebaseFirestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  await db
      .collection("userData")
      .doc(uEmail)
      .collection("card")
      .doc(uEmail)
      .set({
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

  QuerySnapshot snapshot = await FirebaseFirestore.instance
      .collection("userData")
      .doc(uEmail)
      .collection("card")
      .get();

  List<UserDataCard> _userDataCardList = [];

  snapshot.docs.forEach((doc) {
    UserDataCard userDataCard = UserDataCard.fromMap(doc.data());
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
  final db = FirebaseFirestore.instance;
  final uEmail = await AuthService().getCurrentEmail();

  CollectionReference cardRef =
      db.collection("userData").doc(uEmail).collection("card");
  await cardRef.doc(uEmail).update(
    {
      'cardHolder': cardHolder,
      'cardNumber': cardNumber,
      'validThrough': validThrough,
      'securityCode': securityCode,
    },
  );
}

saveDeviceToken() async {
  final db = FirebaseFirestore.instance;
  final _fcm = FirebaseMessaging();

  final uEmail = await AuthService().getCurrentEmail();

  //Getting device token
  String fcmToken = await _fcm.getToken();

  //Storing token
  if (fcmToken != null) {
    await db.collection("userToken").doc(uEmail).set({
      'userEmail': uEmail,
      'token': fcmToken,
      'createdAt': FieldValue.serverTimestamp(),
      'platform': Platform.operatingSystem,
    });
  }
}
