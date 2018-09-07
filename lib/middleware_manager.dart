import 'package:redux/redux.dart';
import 'address_controller.dart';
import 'app_state.dart';
import 'actions.dart';

abstract class StateMiddleware {
  Middleware<AppState> addressMiddleware;
  Middleware<AppState> loggingMiddleware;

  List<Middleware> middlewares();
}

class MiddlewareManager implements StateMiddleware {
  Middleware<AppState> addressMiddleware;
  Middleware<AppState> loggingMiddleware;

  MiddlewareManager(AddressControllerType controller) {
    addressMiddleware = TypedMiddleware<AppState, LoadAddressesAction>(controller.loadAddresses);
    loggingMiddleware = TypedMiddleware<AppState, dynamic>(controller.logging);
  }

  List<Middleware> middlewares() => [addressMiddleware, loggingMiddleware];
}
