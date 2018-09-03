import 'dart:async';

import '../address.dart';
import 'address_provider_type.dart';

class AddressProvider implements AddressProviderType {
  List<Address> addressList = [
    Address(city: 'Berlin', street: 'Walkenstrasse', number: 10),
    Address(city: 'Yerevan', street: 'Koryun', number: 7),
    Address(city: 'Berlin', street: 'paul-lincke-uffer', number: 39),
  ];

  AddressProvider() {}

  factory AddressProvider.instance() => AddressProvider();

  Future<List<Address>> load() async {
    // throw Exception('an error!');
    return Future.delayed(Duration(seconds: 2), () => addressList);
  }

  Future<bool> save() async {
    return Future.delayed(Duration(seconds: 1), () => true);
  }
}
