import 'package:flutter/material.dart';
import 'package:address_book/address.dart';
import 'package:address_book/assets.dart';
import 'package:address_book/body_element.dart';


//Main App entrance
void main() {
  Address address = Address('Berlin', 'Paul Linke Ufer', 39);

  AddressBookApp addressBookApp = AddressBookApp();
  return runApp(addressBookApp);
}


