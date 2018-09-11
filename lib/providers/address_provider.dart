import 'dart:async';

import '../address.dart';
import '../PreferencesRepository.dart';
import 'address_provider_type.dart';

class AddressProvider implements AddressProviderType {
  List<Address> addressList = [
    Address(city: 'Berlin', street: 'Walkenstrasse', number: 10),
    Address(city: 'Yerevan', street: 'Koryun', number: 7),
    Address(city: 'Berlin', street: 'paul-lincke-uffer', number: 39),
  ];

  AddressProvider();

  PrefernecesStorage _prefsStorage = PrefernecesStorage();

  factory AddressProvider.instance() => AddressProvider();

  Future<List<Address>> load() async {
    // throw Exception('an error!');
    return _prefsStorage.loadAddressList();
  }

  Future<bool> save(Address address) async {
    _prefsStorage.saveAddresses(address).then((_) {
      return true;
    }).catchError((_) {
      return false;
    });
  }
}
