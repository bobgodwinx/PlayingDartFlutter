import 'package:address_book/providers/account_provider.dart';
import 'package:address_book/redux/actions.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:redux/redux.dart';

abstract class AccountControllerType {
  void signUp(Store<AppState> store, SignUpAction action, NextDispatcher next);

  void signIn(Store<AppState> store, SignInAction action, NextDispatcher next);
}

class AccountController implements AccountControllerType {
  AccountProvider _accountProvider;

  AccountController(this._accountProvider);

  @override
  void signUp(Store<AppState> store, SignUpAction action, NextDispatcher next) {
    _accountProvider
        .signupWithEmail(action.email, action.password)
        .then((user) {
      store.dispatch(SignUpSucceededAction(user));
    }).catchError((onError) {
      store.dispatch(SignUpErrorAction(onError));
    });
    next(action);
  }

  @override
  void signIn(Store<AppState> store, SignInAction action, NextDispatcher next) {
    _accountProvider
        .signinWithEmail(action.email, action.password)
        .then((user) {
      store.dispatch(SignInSucceededAction(user));
    }).catchError((onError) {
      store.dispatch(SignInErrorAction(onError));
    });
    next(action);
  }
}
