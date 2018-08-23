import 'package:flutter/material.dart';
import 'package:address_book/home_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:address_book/AppState.dart';
import 'package:address_book/reducers.dart';
import 'package:address_book/actions.dart';



//Main App entrance
void main() {
  AddressBookApp addressBookApp = AddressBookApp();
  return runApp(addressBookApp);
}

class AddressBookApp extends StatelessWidget {

  final Store<AppState> store = Store(appStateReducer, initialState: AppState.initialState()); 

  @override
    Widget build(BuildContext context) {
      Widget home = StoreBuilder<AppState>(onInit: (Store<AppState> store) => store.dispatch(LoadCurrentScreen()), 
                                         builder: (context, store) => HomeScreen() );
     MaterialApp child = MaterialApp(title: 'Hello', routes: {"/": (context) => home });
      return StoreProvider(store: store, child: child);
    }
}


