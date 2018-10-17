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

class SignupAction extends LoadAction {
  String email;
  String password;

  SignupAction({@required this.email, @required this.password});
}

class SigninAction extends LoadAction {
  String email;
  String password;

  SigninAction({@required this.email, @required this.password});
}

class SignupSucceededAction extends LoadAction {
  User user;

  SignupSucceededAction(this.user);
}

class SigninSucceededAction extends LoadAction {
  User user;

  SigninSucceededAction(this.user);
}
class SignupErrorAction extends LoadAction {
  User user;

  SignupErrorAction(this.user);
}


