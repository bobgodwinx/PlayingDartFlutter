import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import '../address.dart';
import '../app_state.dart';
import 'add_address_view_model.dart';

class AddAddressScreen extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _cityKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _streetKey =
      GlobalKey<FormFieldState<String>>();

  static GlobalKey<FormFieldState<String>> get cityKey => _cityKey;

  static GlobalKey<FormFieldState<String>> get streetKey => _streetKey;

  @override
  Widget build(BuildContext context) {
    /// Returns a StatelessWidget that is updateable 
    /// Has access to current State<AppState>
    return StoreConnector<AppState, AddAddressViewModel>(
      converter: _converter,
      builder: _builder,
    );
  }
  /// Returns a viewModel Typeof<AddAddressViewModel> when given a store
  AddAddressViewModel _converter(Store<AppState> store) {
    return AddAddressViewModel.initWithStore(store);
  }
  /// Returns a Widget or View when given a context + viewModel
  Widget _builder(BuildContext context, AddAddressViewModel viewModel) {
    AppBar appBar = AppBar(
      title: Text('Add Address'),
      elevation: 0.0,
    );

    return Scaffold(
      appBar: appBar,
      body: _body(context, viewModel),
    );
  }

  Widget _body(BuildContext context, AddAddressViewModel viewModel) {
    Widget streetField = TextFormField(
      key: _streetKey,
      validator: viewModel.streetValidator,
      decoration: InputDecoration(
        hintText: 'Street',
      ),
    );
    Widget cityField = TextFormField(
      key: _cityKey,
      validator: viewModel.cityValidator,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'City',
      ),
    );

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          streetField,
          cityField,
          _button(context, viewModel)
        ],
      ),
    );
  }

  Widget _button(BuildContext context,  AddAddressViewModel viewModel) {
    Color color = Theme.of(context).primaryColor;
    RaisedButton button = RaisedButton(
      child: Text('Add'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          Address address = Address(
            city: _cityKey.currentState.value,
            street: _streetKey.currentState.value,
          );
          /// Communicates a Typeof<Address> to <ViewModel> 
          viewModel.addressHandler(address);
          Navigator.pop(context);
        }
      },
      color: color,
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: button,
    );
  }
}
