import 'dart:async';

import 'package:address_book/address.dart';
import 'package:address_book/repositories/repository.dart';
import 'package:address_book/resource.dart';

abstract class AddressProviderType implements Resource<List<Address>> {}

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
