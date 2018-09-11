import 'dart:async';

import 'address.dart';

abstract class Resource<T> {
  Future<T> load();

  Future<bool> save(Address address);
}
