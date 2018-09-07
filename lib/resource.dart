import 'dart:async';

abstract class Resource<T> {
  Future<T> load();

  Future<bool> save();
}
