import 'package:redux/redux.dart';

import 'app_state.dart';
import 'actions.dart';
import 'providers/address_provider_type.dart';

abstract class StateMiddleware {
  Middleware<AppState> addressMiddleware;
  Middleware<AppState> loggingMiddleware;

  List<Middleware> middlewares();
}

class MiddlewareManager implements StateMiddleware {
  Middleware<AppState> addressMiddleware;
  Middleware<AppState> loggingMiddleware;

  AddressProviderType _addressProvider;

  MiddlewareManager({AddressProviderType addressProvider}) {
    this._addressProvider = addressProvider;
    
    /// Loads address list.
    /// Dispatches an action IsLoadingAction when starts loading.
    /// When loading is finished IsLoadingAction and LoadedAddressesAction are dispatched.
    _loadAddresses(Store<AppState> store, LoadAddressesAction action, NextDispatcher next) {
      next(IsLoadingAction(true));

      _addressProvider.load().then((addressList) {
        next(LoadedAddressesAction(addressList));
        next(IsLoadingAction(false));
      }).catchError((e) {
        print('onError: exception $e');
        next(IsLoadingAction(false));
      });
    }

    /// Logs state and an action
    _logging(Store<AppState> store, dynamic action, NextDispatcher next) {
      print(store.state);
      print('action: $action');

      next(action);
    }

    addressMiddleware =
        TypedMiddleware<AppState, LoadAddressesAction>(_loadAddresses);
    loggingMiddleware = TypedMiddleware<AppState, dynamic>(_logging);
  }

  List<Middleware> middlewares() {
    return [addressMiddleware, loggingMiddleware];
  }
}
