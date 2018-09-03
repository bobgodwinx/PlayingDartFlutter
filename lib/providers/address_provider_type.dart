import 'dart:async';

import '../address.dart';
import '../resource.dart';

abstract class AddressProviderType implements Resource<List<Address>> {
  Future<List<Address>> load();
  Future<bool> save();
}

