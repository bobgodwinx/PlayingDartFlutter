import 'package:address_book/redux/actions.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:redux/redux.dart';

typedef SignupHandler = void Function(String email, String password);

class SignupViewModel {
  final SignupHandler signupHandler;

  SignupViewModel._internal({this.signupHandler});

//  todo improve validators
  String emailValidator(String item) => item.isEmpty ? "Password is empty" : null;

  String passwordValidator(String item) => item.isEmpty ? "Email is empty" : null;

  factory SignupViewModel.initWithStore(Store<AppState> store) {
    void handler(String email, String password) {
      store.dispatch(SignUpAction(email: email, password: password));
    }

    return SignupViewModel._internal(signupHandler: handler);
  }
}
