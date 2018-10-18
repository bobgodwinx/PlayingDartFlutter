import 'dart:async';

import 'package:address_book/models/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../address.dart';
import 'repository.dart';

class FirebaseRepository implements Repository {
  String documentPath = 'address';

  static final instance = FirebaseRepository._internal();

  FirebaseRepository._internal();

  Future<List<Address>> loadAddressList() async {
    final snapshot = Firestore.instance.collection(documentPath).snapshots();
    if (snapshot != null) {
      await for (var i in snapshot) {
        var addressList = i.documents
            .map((document) => Address.fromJson(document.data))
            .toList();

        return addressList;
      }
    }
    return [Address.initialAddress()];
  }

  addAddress(Address address) async {
    Firestore.instance
        .collection(documentPath)
        .document()
        .setData(address.toJson());

    return true;
  }

  @override
  Future<User> signInWithEmail(String email, String password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return User.fromFirebase(firebaseUser);
  }

  @override
  Future<User> signUpWithEmail(String email, String password) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseUser firebaseUser = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return User.fromFirebase(firebaseUser);
  }
}
