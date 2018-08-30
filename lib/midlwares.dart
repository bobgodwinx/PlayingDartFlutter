import 'package:redux/redux.dart';

import 'app_state.dart';
import 'actions.dart';
import 'repositories/address_repository.dart';

loggingMiddleware(Store<AppState> store, dynamic action, NextDispatcher next) {
  print(store.state);
  print('action: $action');

  next(action);
}

AddressRepository addressRepository = AddressRepositoryImpl();

Middleware<AppState> addressMiddleware =
    TypedMiddleware<AppState, LoadAddressesAction>(loadAddresses);

loadAddresses(
    Store<AppState> state, LoadAddressesAction action, NextDispatcher next) {
      next(IsLoadingAction(true));
  addressRepository.load().then((addressList) {
    next(LoadedAddressesAction(addressList));
    next(IsLoadingAction(false));
  });
}
