import 'dart:async';

import 'package:address_book/models/account.dart';

import '../repositories/repository.dart';

abstract class AccountProviderType {}

class AccountProvider implements AccountProviderType {
  Repository _repository;

  AccountProvider(Repository repository) {
    _repository = repository;
  }

  Future<User> signupWithEmail(String email, String password) async {
    return await _repository.signUpWithEmail(email, password);
  }

  Future<User> signinWithEmail(String email, String password) async {
    return await _repository.signInWithEmail(email, password);
  }
}
