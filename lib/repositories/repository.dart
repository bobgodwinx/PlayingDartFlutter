import 'dart:async';

import '../address.dart';

abstract class Repository {
  Future<List<Address>> loadAddressList();
  Future<bool> addAddress(Address address);
}
