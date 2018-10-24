import 'package:address_book/controllers/account_controller.dart';
import 'package:address_book/controllers/address_controller.dart';
import 'package:address_book/redux/actions.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:redux/redux.dart';

abstract class StateMiddleware {
  Middleware<AppState> loadAddressesMiddleware;
  Middleware<AppState> addAddressMiddleware;
  Middleware<AppState> loggingMiddleware;
  Middleware<AppState> signinMiddleware;
  Middleware<AppState> signupMiddleware;

  List<Middleware> middlewares();
}

class MiddlewareManager implements StateMiddleware {
  Middleware<AppState> loadAddressesMiddleware;
  Middleware<AppState> addAddressMiddleware;
  Middleware<AppState> loggingMiddleware;

  Middleware<AppState> signinMiddleware;
  Middleware<AppState> signupMiddleware;
  Middleware<AppState> signInSucceededMiddleware;

  MiddlewareManager(
      {AddressControllerType addressController, AccountControllerType accountController}) {
    loadAddressesMiddleware =
        TypedMiddleware<AppState, LoadAddressesAction>(addressController.loadAddresses);
    addAddressMiddleware =
        TypedMiddleware<AppState, AddAddressAction>(addressController.addAddress);
    loggingMiddleware = TypedMiddleware<AppState, dynamic>(addressController.logging);

/// Account Middlewares
    signinMiddleware = TypedMiddleware<AppState, SignInAction>(accountController.signIn);
    signupMiddleware = TypedMiddleware<AppState, SignUpAction>(accountController.signUp);
    signInSucceededMiddleware = TypedMiddleware<AppState, SignInSucceededAction>(accountController.signInSucceeded);
  }

  List<Middleware> middlewares() => [
        loggingMiddleware,
        loadAddressesMiddleware,
        addAddressMiddleware,
        signinMiddleware,
        signupMiddleware,
        signInSucceededMiddleware,
      ];
}
