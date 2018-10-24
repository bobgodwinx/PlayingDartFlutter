import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

class User {
  String email;
  String displayName;
  bool isAnonymous;
  bool isEmailVerified;
  Future<String> idToken;

  User.fromFirebase(FirebaseUser user) {
    email = user.email;
    displayName = user.displayName;
    isAnonymous = user.isAnonymous;
    isEmailVerified = user.isEmailVerified;
    idToken = user.getIdToken();
  }
}

class UserCredentials{
  String email;
  String password;
  UserCredentials({this.email, this.password});
}
