import 'package:address_book/redux/actions.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:redux/redux.dart';

typedef LoginHandler = void Function(String email, String password);

class AccountScreenViewModel {
  final LoginHandler loginHandler;

  AccountScreenViewModel._internal({this.loginHandler});

//  todo improve validators
  String emailValidator(String item) =>
      item.isEmpty ? "Password is empty" : null;

  String passwordValidator(String item) =>
      item.isEmpty ? "Email is empty" : null;

  factory AccountScreenViewModel.initWithStore(Store<AppState> store) {
    void loginHandler(String email, String password) {
      store.dispatch(SignInAction(email: email, password: password));
    }

    return AccountScreenViewModel._internal(loginHandler: loginHandler);
  }
}
