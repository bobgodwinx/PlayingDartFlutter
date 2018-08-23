import 'package:address_book/address.dart';
import 'package:address_book/AppState.dart';
import 'package:address_book/screens.dart';

class LoadAddressesAction {}

class LoadCurrentScreen {
  final Screens currentScreen;
  
  LoadCurrentScreen({this.currentScreen});
}
