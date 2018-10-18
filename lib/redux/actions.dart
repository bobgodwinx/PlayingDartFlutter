import 'package:address_book/address.dart';
import 'package:address_book/models/account.dart';
import 'package:address_book/screen.dart';
import 'package:flutter/foundation.dart';

class LoadAddressesAction {}

class ScreenUpdateAction {
  final Screen screen;

  ScreenUpdateAction({this.screen});
}

class LoadedAddressesAction {
  final List<Address> addressList;

  LoadedAddressesAction(this.addressList);
}

class SaveAddressesAction {
  Address address;

  SaveAddressesAction(this.address);
}

class AddAddressAction {
  final Address address;

  AddAddressAction(this.address);
}

class LoadAction {
  final bool isLoading = true;
}

class IsLoadingAction extends LoadAction {
  @override
  final bool isLoading;

  IsLoadingAction(this.isLoading);
}

class SignUpAction extends LoadAction {
  String email;
  String password;

  SignUpAction({@required this.email, @required this.password});
}

class SignInAction extends LoadAction {
  String email;
  String password;

  SignInAction({@required this.email, @required this.password});
}

class SignUpSucceededAction extends LoadAction {
  User user;

  SignUpSucceededAction(this.user);
}

class SignInSucceededAction extends LoadAction {
  User user;

  SignInSucceededAction(this.user);
}

class SignInErrorAction extends LoadAction {
  Error error;

  SignInErrorAction(this.error);
}

class SignUpErrorAction extends LoadAction {
  Error error;

  SignUpErrorAction(this.error);
}
