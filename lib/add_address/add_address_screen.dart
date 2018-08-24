import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../address.dart';
import '../app_state.dart';
import '../actions.dart';
import '../address.dart';

import 'view_model.dart';

class AddAddressScreen extends StatelessWidget {
  converter(Store<AppState> state) {
    return;
  }

  @override
  Widget build(BuildContext context) {
    
    return StoreConnector<AppState, AddAddressViewModel>(
        converter: (store) => AddAddressViewModel(
            addressHandler: (Address address) =>
                store.dispatch(AddAddressAction(address))),
        builder: (BuildContext context, AddAddressViewModel viewModel) {
          AppBar appBar = AppBar(
            title: Text('Berlin'),
            elevation: 0.0,
          );

          Column body = Column(children: [
            _body(context),
            _button(context, viewModel.addressHandler)
          ]);
          return Scaffold(appBar: appBar, body: body);
        });
  }

  Widget _body(BuildContext context) {
    var children = [
      TextField(
        decoration: InputDecoration(
            border: InputBorder.none, hintText: 'Please enter a search term'),
      )
    ];
    Column childView = Column(children: children);
    return Card(child: childView);
  }

  Widget _button(BuildContext context, AddAddressHandler addressHandler) {
    Address address = Address(city: "Lagos", number: 30, street: 'Holy Street');
    Color color = Theme.of(context).primaryColor;
    RaisedButton button = RaisedButton(
        child: Text('Add'),
        onPressed: () => addressHandler(address),
        color: color);
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        child: button);
  }

  Widget _addressInput(BuildContext context) {}
}
