import 'dart:async';

import 'package:address_book/address.dart';

abstract class Resource<T> {
  Future<T> load();

  Future<bool> save(Address address);
}
