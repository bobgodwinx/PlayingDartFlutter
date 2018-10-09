import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'actions.dart';
import 'add_address/add_address_screen.dart';
import 'address_controller.dart';
import 'app_state.dart';
import 'home/home_screen.dart';
import 'middleware_manager.dart';
import 'providers/address_provider.dart';
import 'reducers.dart';
import 'repositories/firebase_repository.dart';
import 'routes.dart';
import 'screen.dart';

//Main App entrance
void main() {
  bool isInDebugMode = false;

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  runZoned<Future<Null>>(_runApp, onError: _onError);
}

Future<Null> _runApp() async {
  AddressBookApp addressBookApp = AddressBookApp();
  runApp(addressBookApp);
}

void _onError(error, stackTrace) async {
  await FlutterCrashlytics().reportCrash(error, stackTrace, forceCrash: false);
}

class AddressBookApp extends StatelessWidget {
  final Store<AppState> store = Store(
    ReducerManager().appStateReducer,
    initialState: AppState.initialState(),
    middleware:
        MiddlewareManager(AddressController(AddressProvider(FirebaseRepository()))).middlewares(),
    distinct: true,
  );

  @override
  Widget build(BuildContext context) {
    Widget home = StoreBuilder<AppState>(
      onInit: (Store<AppState> store) {
        store.dispatch(ScreenUpdateAction(screen: Screen.home));
        store.dispatch(LoadAddressesAction());
      },
      builder: (context, store) => HomeScreen(),
    );

    Widget addAddress = StoreBuilder<AppState>(
      onInit: (Store<AppState> store) {},
      builder: (context, store) => AddAddressScreen(),
    );

    var routes = {
      Routes.home: (context) => home,
      Routes.addAddress: (context) => addAddress,
    };

    MaterialApp child = MaterialApp(title: 'Hello', routes: routes);
    return StoreProvider(store: store, child: child);
  }
}
