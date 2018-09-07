import 'package:redux/redux.dart';

import 'actions.dart';
import 'address_controller.dart';
import 'app_state.dart';

abstract class StateMiddleware {
  Middleware<AppState> loadAddressesMiddleware;
  Middleware<AppState> addAddressMiddleware;
  Middleware<AppState> loggingMiddleware;

  List<Middleware> middlewares();
}

class MiddlewareManager implements StateMiddleware {
  Middleware<AppState> loadAddressesMiddleware;
  Middleware<AppState> addAddressMiddleware;
  Middleware<AppState> loggingMiddleware;

  MiddlewareManager(AddressControllerType controller) {
    loadAddressesMiddleware =
        TypedMiddleware<AppState, LoadAddressesAction>(controller.loadAddresses);
    addAddressMiddleware = TypedMiddleware<AppState, AddAddressAction>(controller.saveAddresses);
    loggingMiddleware = TypedMiddleware<AppState, dynamic>(controller.logging);
  }

  List<Middleware> middlewares() =>
      [loggingMiddleware, loadAddressesMiddleware, addAddressMiddleware];
}
