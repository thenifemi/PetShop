import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
        (FirebaseUser user) => user?.uid,
      );

  //Get UID
  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }

  //Get Cureent user
  Future getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }

  //Email and Pasword Sign Up
  Future<String> createUserWithEmailAndPassword(
      String email, String password, String name, String phoneNumber) async {
    final currentUser = (await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    //Update the users name
    var userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await currentUser.updateProfile(userUpdateInfo);
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
                email: email, password: password))
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

//VALIDATORS

class NameValiditor {
  static String validate(String val) {
    print(val);
    if (val.isEmpty) {
      return "Enter your name";
    } else if (val.length < 2) {
      return "Name has to be atleast 2 characters";
    } else if (val.length > 20) {
      return "Name is too long";
    } else {
      return null;
    }
  }
}

class EmailValiditor {
  static String validate(String val) {
    print(val);
    if (!val.contains("@") || !val.contains(".")) {
      return "Enter a valid Email address";
    } else if (val.isEmpty) {
      return "Enter your Email address";
    } else {
      return null;
    }
  }
}

class PasswordValiditor {
  static String validate(String val) {
    Pattern pattern = r'(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])';
    RegExp regex = RegExp(pattern);
    print(val);
    if (val.isEmpty) {
      return "Enter a password";
    } else if (val.length < 6 || (!regex.hasMatch(val))) {
      return "Password not strong enough";
    } else {
      return null;
    }
  }
}

class PhoneNumberValiditor {
  static String validate(String val) {
    String pattern = r'(^(?:[+0]9)?[0-9]{13}$)';
    RegExp regex2 = new RegExp(pattern);
    print(val);
    if (!regex2.hasMatch(val)) {
      return "Enter a valid phone number";
    } else {
      return null;
    }
  }
}
