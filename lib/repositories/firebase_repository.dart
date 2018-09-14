import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../address.dart';
import 'repository.dart';

class FirebaseRepository implements Repository {
  String documentPath = 'address';
  Future<List<Address>> loadAddressList() async {
    final snapshot = Firestore.instance.collection(documentPath).snapshots();
    await for (var i in snapshot) {
      var addressList = i.documents
          .map((document) => Address.fromJson(document.data))
          .toList();

      return addressList;
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
}
