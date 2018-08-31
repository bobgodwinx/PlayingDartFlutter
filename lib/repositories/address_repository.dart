import 'dart:async';

import '../address.dart';

abstract class AddressRepository {
  Future<List<Address>> load();
  Future<bool> save();
}

class AddressRepositoryImpl implements AddressRepository {
  List<Address> addressList = [
    Address(city: 'Berlin', street: 'Walkenstrasse', number: 10),
    Address(city: 'Yerevan', street: 'Koryun', number: 7),
    Address(city: 'Berlin', street: 'paul-lincke-uffer', number: 39),
  ];
  Future<List<Address>> load() async {
    return Future.delayed(Duration(seconds: 2), () => addressList);
  }

  Future<bool> save() async {
    return Future.delayed(Duration(seconds: 1), () => true);
  }
}
