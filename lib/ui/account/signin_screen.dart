import 'package:address_book/redux/app_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'signin_view_model.dart';

class SignInScreen extends StatelessWidget {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();

  static GlobalKey<FormFieldState<String>> get emailKey => _emailKey;

  static GlobalKey<FormFieldState<String>> get passwordKey => _passwordKey;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AccountScreenViewModel>(
      converter: _converter,
      builder: _builder,
    );
  }

  /// Returns a viewModel Typeof<AccountScreenViewModel> when given a store
  AccountScreenViewModel _converter(Store<AppState> store) {
    return AccountScreenViewModel.initWithStore(store);
  }

  /// Returns a Widget or View when given a context + viewModel
  Widget _builder(BuildContext context, AccountScreenViewModel viewModel) {
    AppBar appBar = AppBar(
      title: Text('Account'),
      elevation: 0.0,
    );

    return Scaffold(
      appBar: appBar,
      body: _body(context, viewModel),
    );
  }

  Widget _body(BuildContext context, AccountScreenViewModel viewModel) {
    Widget passwordField = TextFormField(
      key: _passwordKey,
      obscureText: true,
      validator: viewModel.passwordValidator,
      decoration: InputDecoration(
        hintText: 'password',
      ),
    );
    Widget emailField = TextFormField(
      key: _emailKey,
      keyboardType: TextInputType.emailAddress,
      validator: viewModel.emailValidator,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'email',
      ),
    );

    return Form(
      key: _formKey,
      child: ListView(
        children: [emailField, passwordField, _button(context, viewModel)],
      ),
    );
  }

  Widget _button(BuildContext context, AccountScreenViewModel viewModel) {
    Color color = Theme.of(context).primaryColor;
    RaisedButton button = RaisedButton(
      child: Text('Login'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          final email = _emailKey.currentState.value;
          final password = _passwordKey.currentState.value;

          viewModel.loginHandler(email, password);
        }
      },
      color: color,
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
      child: button,
    );
  }

  void _login() {}
}
