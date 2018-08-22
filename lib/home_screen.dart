import 'package:flutter/material.dart';
import 'package:address_book/assets.dart';
import 'package:address_book/body_element.dart';
import 'package:address_book/keys.dart';
import 'package:address_book/root_widget.dart';
import 'package:address_book/screens.dart';
import 'package:address_book/home_screen_view_model.dart';
import 'package:address_book/address.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      RootWidget rootWidget = RootWidget(builder: (BuildContext context, HomeScreenViewModel viewModel) {
        AppBar appBar = AppBar(title: Text('Berlin'), elevation: 0.0,);
        ThemeData appThemeData = ThemeData(primarySwatch: Colors.indigo);
        Column body = Column(children: [_body(context, viewModel), _button(context, viewModel.listHandler)]);
        return Scaffold(appBar: appBar, body: body);
      });
      return rootWidget;
  }


  Widget _body(BuildContext context, HomeScreenViewModel viewModel) {
    ///todo: moves this code to the viewmodel for mvvm
      var children = viewModel.list.map((item) => Text(item.city)).toList();
      /// here is ok
      Column childView = Column(children: children);
      return Card(child: childView);
  }

  Widget _button(BuildContext context, AddAddressHandler handler) {
    Address address = Address(city: "Lagos", number: 30, street: 'Holy Street');
    Color color = Theme.of(context).primaryColor;
    RaisedButton button = RaisedButton(child: Text('Add'), onPressed: () => handler(address), color: color);
    return Container(margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), child: button);
  }

}

