import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //Checking if user is signed in
  Stream<String> get onAuthStateChanged => _firebaseAuth.authStateChanges().map(
        (User user) => user?.uid,
      );

  //Get UID
  Future<String> getCurrentUID() async {
    return (_firebaseAuth.currentUser).uid;
  }

  //Get Email
  Future<String> getCurrentEmail() async {
    return (_firebaseAuth.currentUser).email;
  }

  //Get Current user
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  //Email and Pasword Sign Up
  Future<String> createUserWithEmailAndPassword(
    email,
    password,
    name,
  ) async {
    final User currentUser =
        (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
            .user;

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
