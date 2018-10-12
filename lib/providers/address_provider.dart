import 'dart:async';

import '../address.dart';
import '../repositories/repository.dart';

import 'address_provider_type.dart';

class AddressProvider implements AddressProviderType {
  Repository _repository;

  AddressProvider(Repository repository) {
    _repository = repository;
  }

  Future<List<Address>> load() async {
    // throw Exception('an error!');
    return await _repository.loadAddressList();
  }

  Future<bool> save(Address address) async {
    return await _repository.addAddress(address).then((_) {
      return true;
    }).catchError((_) {
      return false;
    });
  }
}
