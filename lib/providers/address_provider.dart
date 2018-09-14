import 'dart:async';

import '../address.dart';
import '../repositories/firebase_repository.dart';
import '../repositories/repository.dart';

import 'address_provider_type.dart';

class AddressProvider implements AddressProviderType {
  
//todo use dependency injection?
  Repository _repositry = FirebaseRepository();

  AddressProvider.instance();

  Future<List<Address>> load() async {
    // throw Exception('an error!');
    return await _repositry.loadAddressList();
  }

  Future<bool> save(Address address) async {
    await _repositry.addAddress(address).then((_) {
      return true;
    }).catchError((_) {
      return false;
    });
  }
}
