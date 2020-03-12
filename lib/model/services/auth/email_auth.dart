import 'package:firebase_auth/firebase_auth.dart';
import 'package:mollet/model/services/user_management.dart';
import 'package:flutter/widgets.dart';
import 'package:mollet/screens/register_screens/login_screen.dart';

//REGISTER (CONTINUED IN user_management.dart)
// void performRegistration(_email, _password, _name, context) {
//   FirebaseAuth.instance
//       .createUserWithEmailAndPassword(
//     email: _email,
//     password: _password,
//   )
//       .then((signedInUser) {
//     // FirebaseUser user;
//     var userUpdateInfo = new UserUpdateInfo();
//     userUpdateInfo.displayName = _name;
//     UserManagement().storeNewUser(signedInUser.user, _name, context);
//     Navigator.of(context).pushReplacementNamed("/Homescreen");
//   }).catchError((e) {
//     print(e);
//   });
// }

//LOGIN

// void performLogin(_email, _password, context, _error) {
//   FirebaseAuth.instance
//       .signInWithEmailAndPassword(
//     email: _email,
//     password: _password,
//   )
//       .then((user) {
//     Navigator.of(context).pushReplacementNamed("/Homescreen");
//   }).catchError((e) {
    
//       _error = e.message;
    
//     print(e);
//   });
// }

//LOGOUT
void performLogout(context) {
  FirebaseAuth.instance.signOut().then((val) {
    Navigator.of(context).pushReplacementNamed("/Login");
  }).catchError((e) {
    print(e);
  });
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
