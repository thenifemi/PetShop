import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Checking if user is signed in
  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  //Get UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  //Get UID
  Future<String> getCurrentEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }

  //Get Current user
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  //Email and Pasword Sign Up
  Future<String> createUserWithEmailAndPassword(
    email,
    String password,
    name,
  ) async {
    final FirebaseUser currentUser =
        (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
            .user;

    //Update the users name
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
    await currentUser.reload();
    return currentUser.uid;
  }

  //Email and Password Sign in
  Future<String> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return ((await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
            .user)
        .uid;
  }

  //Sign Out
  signOut() {
    return FirebaseAuth.instance.signOut();
  }

  //Reset password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
