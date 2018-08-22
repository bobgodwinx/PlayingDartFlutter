import 'package:flutter/material.dart';
import 'package:address_book/assets.dart';
import 'package:address_book/body_element.dart';
import 'package:address_book/keys.dart';

class AddressBookApp extends StatelessWidget {
  AddressBookApp();

  static List<String> _list = [Assets.noAddressFound, Assets.singleFile];

  var _listHandler = (String item) { 
    _list.add(item);
  };
  
  @override
  Widget build(BuildContext context) {

      AppBar appBar = AppBar(title: Text('Berlin'), elevation: 0.0,);
      ThemeData appThemeData = ThemeData(primarySwatch: Colors.indigo);
      Scaffold scaffold = Scaffold(appBar: appBar, body: BodyElementManager(_list, _listHandler));
      return MaterialApp(home: scaffold, theme: appThemeData); 
  }
  
}


