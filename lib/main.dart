import 'package:flutter/material.dart';
import 'package:address_book/address.dart';
import 'package:address_book/assets.dart';
import 'package:address_book/body_element.dart';


//Main App entrance
void main() {
   /// Constructors
  
  void afunction() {
    print('A Function');
  }
  
  afunction();
  
  void bfunction(String aString, int anInt) { 
    print(aString+' $anInt '); 
  }
  
  bfunction('heloo', 67);
  
  void cfunction({String aString, @required int anInt}) {
    print(aString+' $anInt '); 
  }
  
  cfunction(aString: 'named function', anInt: 67);
  //People pp = People('aaaa', 12, 'D');
  List<String> _list = const ['kkkkkkk', 'hhhhhhhh']; 
  List<String> _list2 =  ['ccccc', 'rrrrrr']; 
  Person p = Person(age: 12, sex: 'M', list: _list); /// named arguements
  _list = _list2;
  print(_list);
  //p.list.add('mmmmmmm');

  People pp = People('Resma', 33, 'F', const ['dgdgdgd', 'dhdhdhdc']);
  print(pp.name+' - ${pp.age}');
  //pp.list.add('agagga');
  print(pp.list);
  print(p.name);
  //p.list.add('o');////,,,,,,
  print(p.list);

  User u = User('hello');

  print(u.name);

  p.list = _list2;

  print(p.list);


  Address address = Address('Berlin', 'Paul Linke Ufer', 39);

  AddressBookApp addressBookApp = AddressBookApp();
  return runApp(addressBookApp);
}
  
class Person {

    final String name;
    final int age;
    final String sex;

    List<String> list;

    Person({this.name, this.age, this.sex, this.list});
    //Person(String name, int age, String sex);
  }

  class User {
    final String name;
    //User(this.name);
    const User(this.name);
  }

class People {
  String name;
  int age;
  String sex;
  final List<String> list;

  People([this.name, this.age, this.sex, this.list]);
}

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


