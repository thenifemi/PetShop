import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mollet/widgets/provider.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  Stream<QuerySnapshot> getUsersNameStreamSnapshot(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('usersName')
        .snapshots()
        .asBroadcastStream();
  }
  Stream<QuerySnapshot> getUsersEmailStreamSnapshot(
      BuildContext context) async* {
    final uid = await Provider.of(context).auth.getCurrentUID();
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('usersEmail')
        .snapshots()
        .asBroadcastStream();
  }
}
