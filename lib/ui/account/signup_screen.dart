import 'package:address_book/redux/app_state.dart';
import 'package:address_book/ui/account/signup_view_model.dart';
import 'package:address_book/widgets/signup_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Returns a StatelessWidget that is updatable
    /// Has access to current State<AppState>
    return StoreConnector<AppState, SignupViewModel>(
        converter: _converter, builder: _builder, distinct: false);
  }

  /// Returns a Widget or View when given a context + viewModel
  Widget _builder(BuildContext context, SignupViewModel viewModel) {
    AppBar appBar = AppBar(title: Text('Signup'), elevation: 0.0);
    Widget body = _body(context, viewModel);
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }

  /// Returns a viewModel when given a store
  SignupViewModel _converter(Store<AppState> store) => SignupViewModel.initWithStore(store);

  Widget _body(BuildContext context, SignupViewModel viewModel) {
    return _signupPage(context, viewModel);
  }

  Widget _signupPage(BuildContext context, SignupViewModel viewModel) {
    void _onSignupPressed(String email, String password) {
      print('onSignupPressed');
      viewModel.signupHandler(email, password);
    }

    return SignUpWidget(onSignupPressed: _onSignupPressed);
  }
}
