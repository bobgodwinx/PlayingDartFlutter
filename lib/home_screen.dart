import 'package:flutter/material.dart';
import 'package:address_book/root_widget.dart';
import 'package:address_book/home_screen_view_model.dart';
import 'package:address_book/address.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return RootWidget(builder: (BuildContext context, HomeScreenViewModel viewModel) {
        AppBar appBar = AppBar(title: Text('Berlin'), elevation: 0.0,);
        Column body = Column(children: [_body(context, viewModel), _addressInput(context), _button(context, viewModel.addressHandler)]);
        return Scaffold(appBar: appBar, body: body);
      });
  }

  Widget _body(BuildContext context, HomeScreenViewModel viewModel) {
      var children = viewModel.list.map((item) => Text(item.city)).toList();
      Column childView = Column(children: children);
      return Card(child: childView);
  }

  Widget _button(BuildContext context, AddAddressHandler addressHandler) {
    Address address = Address(city: "Lagos", number: 30, street: 'Holy Street');
    Color color = Theme.of(context).primaryColor;
    RaisedButton button = RaisedButton(child: Text('Add'), onPressed: () => addressHandler(address), color: color);
    return Container(margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0), child: button);
  }

  Widget _addressInput(BuildContext context) {
    return TextField(
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Please enter a search term'
        ),
      );
  }
}

