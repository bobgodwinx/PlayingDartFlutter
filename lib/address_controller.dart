import 'package:redux/redux.dart';

import 'actions.dart';
import 'app_state.dart';
import 'providers/address_provider_type.dart';

abstract class AddressControllerType {
  loadAddresses(Store<AppState> store, LoadAddressesAction action, NextDispatcher next);

  saveAddresses(Store<AppState> store, AddAddressAction action, NextDispatcher next);

  logging(Store<AppState> store, dynamic action, NextDispatcher next);
}

class AddressController implements AddressControllerType {
  AddressProviderType _addressProvider;

  AddressController(this._addressProvider);

  /// Loads address list.
  /// Dispatches an action IsLoadingAction when starts loading.
  /// When loading is finished IsLoadingAction and LoadedAddressesAction are dispatched.
  loadAddresses(Store<AppState> store, LoadAddressesAction action, NextDispatcher next) {
    _addressProvider.load().then((addressList) {
      /// upon arrival of `addressList` we then use
      /// `store` to dispatch our next actions
      store.dispatch(LoadedAddressesAction(addressList));
      store.dispatch(IsLoadingAction(false));
    }).catchError((e) {
      /// In case of Error we handle it here.
      store.dispatch(IsLoadingAction(false));
    });

    /// This is the immediate action
    /// when this closure is called
    next(IsLoadingAction(true));
  }

  /// Saves address list.
  /// Dispatches an action IsLoadingAction when starts saving.
  /// When saving is finished IsLoadingAction is dispatched.
  saveAddresses(Store<AppState> store, AddAddressAction action, NextDispatcher next) {
    store.dispatch(IsLoadingAction(true));

    _addressProvider.save().then((saved) {
      /// upon arrival of `addressList` we then use
      /// `store` to dispatch our next actions
      store.dispatch(IsLoadingAction(false));
    }).catchError((e) {
      /// In case of Error we handle it here.
      store.dispatch(IsLoadingAction(false));
    });

    // /// This is the immediate action
    // /// when this closure is called
    next(action);
  }

  // todo move to it's proper class later
  /// Logs state and an action
  logging(Store<AppState> store, dynamic action, NextDispatcher next) {
    print(store.state);
    print('action: $action');

    next(action);
  }
}
