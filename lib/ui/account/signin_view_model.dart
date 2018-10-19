import 'package:address_book/models/account.dart';
import 'package:address_book/redux/actions.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:redux/redux.dart';

typedef LoginHandler = void Function(String email, String password);

class AccountScreenViewModel {
  final LoginHandler loginHandler;

  AccountScreenViewModel._internal({this.loginHandler, this.user});

//  todo improve validators
  String emailValidator(String item) =>
      item.isEmpty ? "Password is empty" : null;

  String passwordValidator(String item) =>
      item.isEmpty ? "Email is empty" : null;

  User user;

  factory AccountScreenViewModel.initWithStore(Store<AppState> store) {
    void loginHandler(String email, String password) {
      store.dispatch(SignInAction(email: email, password: password));
    }

    return AccountScreenViewModel._internal(loginHandler: loginHandler, user: store.state.user);
  }
}
