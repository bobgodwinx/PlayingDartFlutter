import 'dart:async';

import 'package:address_book/models/account.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:address_book/address.dart';

abstract class Repository {
  Future<List<Address>> loadAddressList();

  Future<bool> addAddress(Address address);

//  todo abstract the FirebaseUser to User
  Future<User> signUpWithEmail(String email, String password);

//  todo abstract the FirebaseUser to User`
  Future<User> signInWithEmail(String email, String password);
}
