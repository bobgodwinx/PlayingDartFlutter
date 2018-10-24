import 'dart:async';

import 'package:address_book/controllers/account_controller.dart';
import 'package:address_book/controllers/address_controller.dart';
import 'package:address_book/keys.dart';
import 'package:address_book/providers/account_provider.dart';
import 'package:address_book/providers/address_provider.dart';
import 'package:address_book/redux/actions.dart';
import 'package:address_book/redux/app_state.dart';
import 'package:address_book/redux/middleware_manager.dart';
import 'package:address_book/redux/reducers.dart';
import 'package:address_book/repositories/firebase_repository.dart';
import 'package:address_book/routes.dart';
import 'package:address_book/screen.dart';
import 'package:address_book/ui/account/signin_screen.dart';
import 'package:address_book/ui/account/signup_screen.dart';
import 'package:address_book/ui/add_address/add_address_screen.dart';
import 'package:address_book/ui/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crashlytics/flutter_crashlytics.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

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
    middleware: MiddlewareManager(
      addressController:
          AddressController(AddressProvider(FirebaseRepository.instance)),
      accountController:
          AccountController(AccountProvider(FirebaseRepository.instance)),
    ).middlewares(),
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

    Widget signup = StoreBuilder<AppState>(
      onInit: (Store<AppState> store) {},
      builder: (context, store) => SignupScreen(),
    );

    Widget signIn = StoreBuilder<AppState>(
      onInit: (Store<AppState> store) {},
      builder: (context, store) => SignInScreen(),
    );

    final routes = {
      Routes.signIn: (context) => signIn,
      Routes.account: (context) => signup,
      Routes.home: (context) => home,
      Routes.addAddress: (context) => addAddress,
    };

    MaterialApp child = MaterialApp(
      title: 'Hello',
      navigatorKey: AppKey.navigatorKey,
      routes: routes,
    );
    return StoreProvider(store: store, child: child);
  }
}
