import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'home/home_screen.dart';
import 'app_state.dart';
import 'reducers.dart';
import 'actions.dart';
import 'add_address/add_address_screen.dart';
import 'routes.dart';
import 'midlwares.dart';
import 'screen.dart';

//Main App entrance
void main() {
  AddressBookApp addressBookApp = AddressBookApp();
  return runApp(addressBookApp);
}

class AddressBookApp extends StatelessWidget {
  final Store<AppState> store = Store(
    ReducerManager().appStateReducer,
    initialState: AppState.initialState(),
    middleware: [loggingMiddleware, addressMiddleware],
  );

  @override
  Widget build(BuildContext context) {
    Widget home = StoreBuilder<AppState>(
        onInit: (Store<AppState> store) {
          store.dispatch(ScreenUpdateAction(screen: Screen.home));
          store.dispatch(LoadAddressesAction());
        },
        builder: (context, store) => HomeScreen());
    Widget addAddress = StoreBuilder<AppState>(
        onInit: (Store<AppState> store) {},
        builder: (context, store) => AddAddressScreen());

    var routes = {
      Routes.home: (context) => home,
      Routes.addAddress: (context) => addAddress
    };

    MaterialApp child = MaterialApp(title: 'Hello', routes: routes);
    return StoreProvider(store: store, child: child);
  }
}
