import 'package:address_book/models/account.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef SignInHandler = void Function(UserCredentials);

class SignInWidget extends StatelessWidget {
  final SignInHandler onSignInPressed;

  SignInWidget({Key key, this.onSignInPressed}) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  static final GlobalKey<FormFieldState<String>> _emailKey =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _passwordKey =
      GlobalKey<FormFieldState<String>>();

  static GlobalKey<FormFieldState<String>> get cityKey => _emailKey;

  static GlobalKey<FormFieldState<String>> get streetKey => _passwordKey;

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text('Sign In'),
      elevation: 0.0,
    );

    return Scaffold(
      appBar: appBar,
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    Widget streetField = TextFormField(
      key: _passwordKey,
      decoration: InputDecoration(
        hintText: 'Password',
      ),
    );
    Widget cityField = TextFormField(
      key: _emailKey,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'email',
      ),
    );

    return Form(
      key: _formKey,
      child: ListView(
        children: [streetField, cityField, _button(context)],
      ),
    );
  }

  Widget _button(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    RaisedButton button = RaisedButton(
      child: Text('Sign In'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          UserCredentials userCredentials = UserCredentials(
            email: _emailKey.currentState.value,
            password: _passwordKey.currentState.value,
          );

          /// Communicates a Typeof<Address> to <ViewModel>
          onSignInPressed(userCredentials);
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
